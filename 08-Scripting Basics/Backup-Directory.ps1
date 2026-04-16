# Script to backup a directory to a specified backup location

# Specify the source directory (the directory you want to backup)
$SourceDirectory = "C:\path\to\source\directory"

# Specify the destination backup directory
$BackupDirectory = "C:\path\to\backup\directory"

# Check if the source directory exists
if (Test-Path -Path $SourceDirectory) {
    
    # Check if the backup directory exists, if not, create it
    if (-not (Test-Path -Path $BackupDirectory)) {
        New-Item -Path $BackupDirectory -ItemType Directory
        Write-Host "Backup directory created: $BackupDirectory"
    }
    
    # Copy the contents from the source to the backup directory
    try {
        Copy-Item -Path $SourceDirectory\* -Destination $BackupDirectory -Recurse -Force
        Write-Host "Backup successful! Files copied from $SourceDirectory to $BackupDirectory"
    } catch {
        Write-Host "Error during backup: $_"
    }
    
} else {
    Write-Host "Source directory does not exist: $SourceDirectory"
}