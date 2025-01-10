Set-Location $PSScriptRoot
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$TransScriptFile = "TransScript_$($timestamp).log"
Start-Transcript $TransScriptFile

# Define parameters
$siteUrl = "https://myorg.sharepoint.com/"
Connect-PnPOnline -Url $siteUrl -UseWebLogin
$VersionsToKeep = 1
# Set the document library name
$libraryName = "Documents"  # Replace with your document library name
$itemsCsv = Get-ChildItem -Filter "*.csv" | Sort-Object LastWriteTime -Descending | Select-Object -First 1
$ListItems = Import-Csv -Path $itemsCsv.FullName | ? {$_.VersionsCount -gt $VersionsToKeep}

# Initialize progress tracking
$TotalItems = $ListItems.Count
$ItemCounter = 0

foreach ($Item in $ListItems) {
    $ItemCounter++    
    try {
        Write-Host -f Yellow "Processing for the file - $($Item.FileUrl)"
        
        $Versions = Get-PnPFileVersion -Url $Item.FileUrl            
        $VersionsCount = $Versions.Count
        $VersionsToDelete = $VersionsCount - $VersionsToKeep
        
        If ($VersionsToDelete -gt 0) {
            $VersionCounter = 0
            # Delete versions
            For ($i = 0; $i -lt $VersionsToDelete; $i++) {
                If ($Versions[$i].IsCurrentVersion) {
                    $VersionCounter++
                    Write-Host -f Magenta "Retaining Current Major Version:" $Versions[$i].VersionLabel
                    Continue
                }
                Write-Host -f Cyan "Deleting Version:" $Versions[$i].VersionLabel
                Remove-PnPFileVersion -Url $Item.FileUrl -Identity $Versions[$i].VersionLabel -Force
            }
            Write-Host -f Green "Version History is cleaned for the File:" $FileUrl
        }
        
        # Update the progress bar
        Write-Progress -PercentComplete (($ItemCounter / $TotalItems) * 100) `
                        -Activity "Processing Files" `
                        -Status "Processing $ItemCounter of $TotalItems files" `
                        -CurrentOperation "Processing $($Item.FileUrl)"
        
        Write-Host "*******************************************************************************"
    }
    catch {
        Write-Host "Error while processing for the item - $($Item.Id) - $($_.Exception.Message)"
    }
}

# Disconnect from SharePoint Online
#Disconnect-PnPOnline

Write-Host "Completed processing of $TotalItems files."

Stop-Transcript
