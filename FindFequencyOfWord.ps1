$timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$transcriptLogFile = "logs\TransScript_$timestamp.txt"
$errorLogFile = "logs\error_log_$timestamp.txt"

Start-Transcript -Path $transcriptLogFile -Append

try {
    Set-Location $PSScriptRoot

    $stopWords = @("utc")
    $batchSize = 1000
    $batchIndex = 0

    $csvReader = Import-Csv -Path "timezone.csv" | Select-Object -ExpandProperty Group

    $allWords = @()

    $totalRecords = $csvReader.Count

    while ($batchIndex * $batchSize -lt $totalRecords) {
        $startIndex = $batchIndex * $batchSize
        $endIndex = [Math]::Min(($batchIndex + 1) * $batchSize - 1, $totalRecords - 1)

        $currentBatch = $csvReader[$startIndex..$endIndex]
        $words = @()

        foreach ($record in $currentBatch) {
            $words += $record.Split(' ') | Where-Object { $_ -notin $stopWords }
        }

        $allWords += $words

        $progressPercentage = (($batchIndex + 1) * $batchSize / $totalRecords) * 100
        $progressPercentage = [Math]::Min($progressPercentage, 100)
        Write-Progress -PercentComplete $progressPercentage -Activity " " -CurrentOperation "$($startIndex + 1) to $($endIndex + 1) of $totalRecords"

        $batchIndex++
    }

    $wordFrequency = $allWords | Group-Object | Sort-Object Count -Descending

    $wordFrequency | Select-Object Name, Count | Export-Csv -Path "WordCount.csv" -NoTypeInformation

    Write-Progress -PercentComplete 100 -Status "Processing Complete" -Activity "Word frequency calculation finished."
    Write-Host "Batch processing complete. Word frequencies exported to 'WordCount.csv'."
} catch {
    $errorMessage = $_.Exception.Message
    Write-Host "Error occurred: $errorMessage"
    Add-Content -Path $errorLogFile -Value "$(Get-Date): $errorMessage"
}

Stop-Transcript
