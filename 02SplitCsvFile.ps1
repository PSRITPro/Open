Set-Location $PSScriptRoot
$sourceCsv = Import-Csv -Path ".\logs\ListItems_20250108_181114.csv"
$linesPerFile = 10

$startRow = 0
$counter =1

while($startRow -lt $sourceCsv.Count){
    $sourceCsv | Select-Object -Skip $startRow -First $linesPerFile | 
                Export-csv -Path ".\Output\ListItems_$($counter).csv" -NoClobber -NoTypeInformation

    $startRow += $linesPerFile
    $counter++
}