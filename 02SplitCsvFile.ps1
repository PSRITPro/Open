Set-Location $PSScriptRoot
$folderPath = "logs"
$csvFile = Get-ChildItem -Path $folderPath -Filter "*.csv" | Sort-Object LastWriteTime -Descending | Select-Object -First 1
$sourceCsv = Import-Csv -Path $csvFile.FullName
$linesPerFile = 10
$startRow = 0
$counter =1
$scriptFile = "03GetAllFileVersions.ps1"
# Create an output directory if it doesn't exist
$outputBasePath = ".\Output"
if (-not (Test-Path -Path $outputBasePath)) {
    New-Item -ItemType Directory -Path $outputBasePath
}

while($startRow -lt $sourceCsv.Count){
    # Create a new folder for each split file
    $folderName = "Split_$($counter)"
    $newFolderPath = Join-Path -Path $outputBasePath -ChildPath $folderName
    if (-not (Test-Path -Path $newFolderPath)) {
        New-Item -ItemType Directory -Path $newFolderPath
    }

    # Define the path for the split CSV file
    $outputCsvPath = Join-Path -Path $newFolderPath -ChildPath "ListItems_$($counter).csv"

    # Export the selected lines to the new CSV in the created folder
    $sourceCsv | Select-Object -Skip $startRow -First $linesPerFile | 
        Export-Csv -Path $outputCsvPath -NoClobber -NoTypeInformation

     # Copy the PowerShell script into the same folder
    Copy-Item -Path $scriptFile -Destination $newFolderPath

    $startRow += $linesPerFile
    $counter++
}