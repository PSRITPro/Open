# Set location path
Set-Location -Path $PSScriptRoot

# Define script file name and timestamp for transcript
$scriptFileName = [System.IO.Path]::GetFileNameWithoutExtension($MyInvocation.MyCommand.Path)
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$transcriptFile = ".\logs\$($scriptFileName)_Transcript_$($timestamp).txt"

# Start transcription
Start-Transcript -Path $transcriptFile

Try {
    # Get the most recent CSV file from the logs folder
    $inputFile = Get-ChildItem -Path ".\logs\" -File -Filter "*.csv" | Sort-Object LastWriteTime -Descending | Select-Object -First 1
    $sqlFiles = Import-Csv -Path $inputFile.FullName

    ForEach ($sql in $sqlFiles) {  
        
        $sqlQueryToRestoreDataabase = Get-Content -Path ".\SqlScriptFiles\RestoreDataBase-SQLQueryFile.sql" -Raw
        $sqlQueryToRestoreDataabase = $sqlQueryToRestoreDataabase -replace '<DatabaseName>', $sql.RestoreDatabaseName `
                                                                    -replace '<DatabaseName>', $sql.RestoreDatabaseName

        $SqlDBServerInstance = "$($sql.RestoreDBServerInstance),$($Sql.Port)"

        # SQL to get logical file names from backup
        $query = "RESTORE FILELISTONLY FROM DISK = N'$($sql.DatabaseBackUpFile)'"

        # Get file list
        $fileList = Invoke-Sqlcmd -ServerInstance $SqlDBServerInstance -Query $query

        # Get default paths
        $dataFilePath = (Invoke-Sqlcmd -ServerInstance $SqlDBServerInstance -Query "SELECT SERVERPROPERTY('InstanceDefaultDataPath') AS DefaultDataPath").DefaultDataPath
        $logFilePath = (Invoke-Sqlcmd -ServerInstance $SqlDBServerInstance -Query "SELECT SERVERPROPERTY('InstanceDefaultLogPath') AS DefaultLogPath").DefaultLogPath

        # Build relocate file list
        $relocateFiles = @()
        foreach ($file in $fileList) {
            $logicalName = $file.LogicalName
            $fileType = $file.Type
            $physicalName = ""

            if ($fileType -eq 'D') {
                $physicalName = "$($dataFilePath)$($sql.RestoreDatabaseName)_Data.mdf"
            } elseif ($fileType -eq 'L') {
                $physicalName = "$($logFilePath)$($sql.RestoreDatabaseName)_Log.ldf"
            }

            $relocateFiles += New-Object Microsoft.SqlServer.Management.Smo.RelocateFile($logicalName, $physicalName)
        }

        # Perform restore
        Restore-SqlDatabase `
            -ServerInstance $sql.RestoreDBServerInstance `
            -Database $sql.RestoreDatabaseName `
            -BackupFile $sql.DatabaseBackUpFile `
            -RelocateFile $relocateFiles `
            -ReplaceDatabase
    }

} Catch {
    Write-Host "Error while getting SQL files from the logs folder - $_" -ForegroundColor Red
}

# Stop transcription
Stop-Transcript
