#Get all process objects
Get-Process

#Count all processes
(Get-Process).Count


#Get specific process details
Get-Process -Name notepad


#Select specific properties from objects
Get-Process | Select-Object Name, Id, CPU


#Sort objects by CPU usage (descending)
Get-Process | Sort-Object CPU -Descending


#Filter objects using Where-Object (CPU > 10)
Get-Process | Where-Object { $_.CPU -gt 10 }


#Get top 5 processes by memory usage
Get-Process | Sort-Object WorkingSet -Descending | Select-Object -First 5


#Get all services
Get-Service


#Filter running services
Get-Service | Where-Object { $_.Status -eq "Running" }


#Select and format service output
Get-Service | Select-Object Name, Status | Format-Table


#Create a custom object
$person = [PSCustomObject]@{
    Name = "John"
    Age  = 30
    City = "Hyderabad"
}


#Display custom object
$person


#Access object properties
$person.Name
$person.Age


#Loop through objects
Get-Process | ForEach-Object {
    $_.Name
}


#Export objects to CSV file
Get-Process | Select-Object Name, Id, CPU | Export-Csv -Path processes.csv -NoTypeInformation