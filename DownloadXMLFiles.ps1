# ========================
# Config
# ========================
$siteUrl       = "https://tenant.sharepoint.com/sites/YourSite"
$libraryName   = "YourFormLibrary"           # Form library name
$downloadRoot  = "C:\Downloads\FormLibrary"  # Local root path

# ========================
# Connect to SharePoint
# ========================
Connect-PnPOnline -Url $siteUrl -Interactive

if (!(Test-Path $downloadRoot)) { 
    New-Item -ItemType Directory -Path $downloadRoot | Out-Null 
}

# ========================
# Get All Items (Paged for large lists)
# ========================
Write-Host "Fetching items from library '$libraryName'..."
$items = Get-PnPListItem -List $libraryName -PageSize 2000 -ScriptBlock { Param($items) $items.Context.ExecuteQuery() }

Write-Host "Total items retrieved:" $items.Count

foreach ($item in $items) {
    # File info
    $fileRef     = $item.FieldValues.FileRef      # e.g. /sites/YourSite/FormLib/Folder1/FormA.xml
    $fileLeafRef = $item.FieldValues.FileLeafRef  # e.g. FormA.xml

    if ($fileLeafRef -like "*.xml") {
        # ========================
        # Build unique local folder name (folder path + file base name)
        # ========================
        $serverPath   = $fileRef.Substring($fileRef.IndexOf($libraryName))  # e.g. FormLib/Folder1/FormA.xml
        $folderPath   = [System.IO.Path]::GetDirectoryName($serverPath)     # e.g. FormLib/Folder1
        $cleanPath    = $folderPath -replace "[^a-zA-Z0-9-_]", "_"          # sanitize folder path
        $formBaseName = [System.IO.Path]::GetFileNameWithoutExtension($fileLeafRef)

        $formFolder   = Join-Path $downloadRoot ($cleanPath + "_" + $formBaseName)

        if (!(Test-Path $formFolder)) { 
            New-Item -ItemType Directory -Path $formFolder | Out-Null 
        }

        # ========================
        # Download XML
        # ========================
        $localXmlPath = Join-Path $formFolder $fileLeafRef
        Write-Host "Downloading XML: $fileLeafRef -> $formFolder"
        Get-PnPFile -Url $fileRef -Path $formFolder -FileName $fileLeafRef -AsFile -Force

        # ========================
        # Download Attachments
        # ========================
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
