# Simple script to get system information

# Get the computer name
$ComputerName = $env:COMPUTERNAME

# Get the current logged-in user
$LoggedInUser = $env:USERNAME

# Output the system information
Write-Host "Computer Name: $ComputerName"
Write-Host "Logged-In User: $LoggedInUser"
