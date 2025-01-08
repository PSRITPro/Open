Set-Location $PSScriptRoot
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$TransScriptFile = "TransScript_$($timestamp).log"
Start-Transcript $TransScriptFile

# Define parameters
$siteUrl = "https://myorg.sharepoint.com/"
Connect-PnPOnline -Url $siteUrl -UseWebLogin

$fileVersionsDetails = "file_versions_report_$($timestamp).csv"
# Set the document library name
$libraryName = "Documents"  # Replace with your document library name
$itemsCsv = Get-ChildItem -Filter "*.csv" | Sort-Object LastWriteTime -Descending | Select-Object -First 1
$ListItems = Import-Csv -Path $itemsCsv.FullName 
foreach ($Item in $ListItems) {
        try{
            $listItem = Get-PnPListItem -List $LibraryName -Id $Item.Id -ErrorAction Stop
            $FileUrl = ($listItem["FileDirRef"] + "/" + $listItem["FileLeafRef"])
            $file = Get-PnPFile -Url $FileUrl #-AsFile
            $Versions = Get-PnPFileVersion -Url $FileUrl
            # Initialize a variable to store the total size of all versions (in bytes)
            $totalSizeBytes = 0

            # Loop through each version and add the size to the total
            foreach ($version in $versions) {
                $versionSize = $version.Size
                $totalSizeBytes += $versionSize  # Add the size of the current version to the total size
            }

            # Convert total size from bytes to MB
            $totalSizeMB = [math]::round($totalSizeBytes / 1MB, 2)
            
            # Export the item details to a CSV file using Export-Csv           
            $listItem | Select @{Name="ItemID";Expression ={$Item.Id}},
                                    @{Name="FileName";Expression ={$listItem["FileLeafRef"]}},
                                    @{Name="FileUrl";Expression ={$FileUrl}},
                                    @{Name="VersionsCount";Expression ={$versions.Count}},
                                    @{Name="TotalVersionsSizeInMB";Expression ={$totalSizeMB}},
                                    @{Name="CurrentVersionSizeinMB";Expression ={[math]::round($file.Length/1MB,2)}},
                                    @{Name="ModifiedBy";Expression ={$listItem["Editor"].LookupValue}} |
                            Export-Csv -Path $fileVersionsDetails -NoTypeInformation -Append

            Write-Host -f Yellow "Scanning File - $($listItem.FieldValues.FileRef)"
            $VersionsCount = $Versions.Count
            $VersionsToDelete = $VersionsCount - $VersionsToKeep
            If($VersionsToDelete -gt 0)
            {
                Write-Host -f Cyan "Total Number of Versions of the File:" $VersionsCount
                $VersionCounter= 0
                #Delete versions
                For($i=0; $i -lt $VersionsToDelete; $i++)
                {
                    If($Versions[$i].IsCurrentVersion)
                    {
                        $VersionCounter++
                        Write-Host -f Magenta "Retaining Current Major Version:" $Versions[$i].VersionLabel
                        Continue
                    }
                    Write-Host -f Cyan "Deleting Version:" $Versions[$i].VersionLabel
                    #Remove-PnPFileVersion -Url $FileUrl -VersionLabel $Versions[$i].VersionLabel
                }                
                Write-Host -f Green "Version History is cleaned for the File:" $FileUrl
            }
            Write-Host "*******************************************************************************"            
        }
        catch{
            Write-Host "Error while processing for the item - $($Item.Id) - $($_.Exception.Message)"
        }
    }
    
# Disconnect from SharePoint Online
#Disconnect-PnPOnline

Write-Host "Completed processing of $TotalProcessed files."


Stop-Transcript