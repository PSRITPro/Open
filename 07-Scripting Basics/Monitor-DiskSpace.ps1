# Script to monitor disk space and alert if usage exceeds a specified threshold

# Specify the threshold for disk usage in percentage
$Threshold = 80

# Get all the logical drives on the system
$Drives = Get-WmiObject Win32_LogicalDisk -Filter "DriveType = 3"

# Loop through each drive and check its usage
foreach ($Drive in $Drives) {
    # Calculate the percentage of used space
    $UsedSpacePercentage = ($Drive.Size - $Drive.FreeSpace) / $Drive.Size * 100

    # If used space exceeds the threshold, send an alert
    if ($UsedSpacePercentage -gt $Threshold) {
        Write-Host "ALERT: Drive $($Drive.DeviceID) is at $([math]::round($UsedSpacePercentage, 2))% usage!"
    } else {
        Write-Host "Drive $($Drive.DeviceID) usage is normal: $([math]::round($UsedSpacePercentage, 2))%"
    }
}