$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$TransScriptFile = "TransScript_$($timestamp).log"
Start-Transcript $TransScriptFile

# Define parameters
$siteUrl = "https://myorg.sharepoint.com/"
#Connect-PnPOnline -Url $siteUrl -UseWebLogin

# Set the document library name
$libraryName = "Documents"  # Replace with your document library name


Set-Location $PSScriptRoot
$ListItems = Import-Csv -Path ".\logs\ListItems_20250108_174843.csv"
foreach ($Item in $ListItems) {
        try{
            $listItem = Get-PnPListItem -List $LibraryName -Id $Item.Id -ErrorAction Stop
            $FileUrl = ($listItem["FileDirRef"] + "/" + $listItem["FileLeafRef"])

            Write-Host -f Yellow "Scanning File - $FileUrl"
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
            $itemDetails | Select @{Name="ItemID";Expression ={$Item.Id}},
                                    @{Name="FileName";Expression ={$listItem["FileLeafRef"]}},
                                    @{Name="FileUrl";Expression ={$FileUrl}},
                                    @{Name="VersionsCount";Expression ={$versions.Count}},
                                    @{Name="TotalSizeMB";Expression ={$totalSizeMB}} |
                            Export-Csv -Path $fileVersionsDetails -NoTypeInformation -Append
                       
            Write-Host "*******************************************************************************"            
        }
        catch{
            Write-Host "Error while processing for the item - $($Item.Id) - $($_.Exception.Message)"
        }
    }
# Disconnect from SharePoint Online
#Disconnect-PnPOnline

Stop-Transcript