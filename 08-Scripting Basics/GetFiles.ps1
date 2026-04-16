# Script to list all files in a specified directory and show their size

# Specify the directory
$DirectoryPath = "E:\GitHub\sptrains\my-learning-journal\PowerShell\Day7"

# Get all files in the directory
$Files = Get-ChildItem -Path $DirectoryPath -File

# Loop through each file and display its name and size
foreach ($File in $Files) {
    Write-Host "File: $($File.Name)"
    Write-Host "File: $($File.Name) - Size: $([math]::round($File.Length / 1MB, 2)) MB"
}
