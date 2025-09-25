# ========================
# Config
# ========================
$siteUrl       = "https://tenant.sharepoint.com/sites/YourSite"
$libraryName   = "YourFormLibrary"           # Form library name
$downloadRoot  = "C:\Downloads\FormLibrary"  # Local root path
$logFolder     = "C:\Downloads\Logs"         # Log folder

# Ensure log folder exists
if (!(Test-Path $logFolder)) { 
    New-Item -ItemType Directory -Path $logFolder | Out-Null 
}

# Prepare log files
$timeStamp     = (Get-Date -Format "yyyyMMdd_HHmmss")
$transcriptLog = Join-Path $logFolder "Transcript_$timeStamp.txt"
$errorLog      = Join-Path $logFolder "Errors_$timeStamp.txt"

# ========================
# Start Logging
# ========================
Start-Transcript -Path $transcriptLog -Append
Write-Host "Transcript started: $transcriptLog"

# Set working location
Set-Location -Path $downloadRoot

# ========================
# Connect to SharePoint
# ========================
try {
    Connect-PnPOnline -Url $siteUrl -Interactive
    Write-Host "Connected to SharePoint: $siteUrl"
}
catch {
    Write-Error "Failed to connect to SharePoint: $_"
    $_ | Out-File -FilePath $errorLog -Append
    Stop-Transcript
    exit
}

# Ensure root download folder exists
if (!(Test-Path $downloadRoot)) { 
    New-Item -ItemType Directory -Path $downloadRoot | Out-Null 
}

# ========================
# Get All Items (Paged for large lists)
# ========================
Write-Host "Fetching items from library '$libraryName'..."
$items = @()

try {
    $items = Get-PnPListItem -List $libraryName -PageSize 2000 -ScriptBlock { Param($items) $items.Context.ExecuteQuery() }
    Write-Host "Total items retrieved:" $items.Count
}
catch {
    Write-Error "Failed to fetch items from $libraryName: $_"
    $_ | Out-File -FilePath $errorLog -Append
}

# ========================
# Process Items
# ========================
foreach ($item in $items) {
    try {
        $fileRef     = $item.FieldValues.FileRef
        $fileLeafRef = $item.FieldValues.FileLeafRef  

        if ($fileLeafRef -like "*.xml") {
            $serverPath   = $fileRef.Substring($fileRef.IndexOf($libraryName))  
            $folderPath   = [System.IO.Path]::GetDirectoryName($serverPath)     
            $cleanPath    = $folderPath -replace "[^a-zA-Z0-9-_]", "_"          
            $formBaseName = [System.IO.Path]::GetFileNameWithoutExtension($fileLeafRef)

            $formFolder   = Join-Path $downloadRoot ($cleanPath + "_" + $formBaseName)

            if (!(Test-Path $formFolder)) { 
                New-Item -ItemType Directory -Path $formFolder | Out-Null 
            }

            # Download XML
            $localXmlPath = Join-Path $formFolder $fileLeafRef
            Write-Host "Downloading XML: $fileLeafRef -> $formFolder"
            Get-PnPFile -Url $fileRef -Path $formFolder -FileName $fileLeafRef -AsFile -Force

            # Download Attachments
            $attachments = Get-PnPProperty -ClientObject $item -Property AttachmentFiles
            if ($attachments.Count -gt 0) {
                $attFolder = Join-Path $formFolder "Attachments"
                if (!(Test-Path $attFolder)) { 
                    New-Item -ItemType Directory -Path $attFolder | Out-Null 
                }

                foreach ($att in $attachments) {
                    Write-Host "   -> Downloading attachment: $($att.FileName)"
                    Get-PnPFile -Url $att.ServerRelativeUrl -Path $attFolder -FileName $att.FileName -AsFile -Force
                }
            }
        }
    }
    catch {
        Write-Error "Error processing item ID $($item.Id): $_"
        $_ | Out-File -FilePath $errorLog -Append
    }
}

# ========================
# End Logging
# ========================
Stop-Transcript
Write-Host "Download completed. Transcript saved: $transcriptLog"
Write-Host "Errors logged (if any): $errorLog"
