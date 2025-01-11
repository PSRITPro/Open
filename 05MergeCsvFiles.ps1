Set-Location $PSScriptRoot
# Define the folder where the CSV files are located
$folderPath = "Output"  # Change this path

# Get all CSV files in the folder
$csvFiles = Get-ChildItem -Path $folderPath -Filter "*.csv"

# Initialize an empty array to hold the content of all CSV files
$mergedData = @()

# Loop through each CSV file and import its content
foreach ($file in $csvFiles) {
    $fileContent = Import-Csv -Path $file.FullName
    $mergedData += $fileContent
}

# Specify the path for the merged CSV file
$mergedCsvPath = ".\Output\MergedFile.csv"  # Change this path

# Export the merged content to a new CSV file
$mergedData | Export-Csv -Path $mergedCsvPath -NoTypeInformation

Write-Host "CSV files have been merged into $mergedCsvPath"
