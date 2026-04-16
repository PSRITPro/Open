############################
#LEVEL 1 – BASIC PIPELINE
############################

#Simple pipeline
Get-Process | Sort-Object CPU

#Filter basic data
Get-Service | Where-Object { $_.Status -eq "Running" }

#Select specific fields
Get-Process | Select-Object Name, Id

#Count objects
Get-Process | Measure-Object


############################
#LEVEL 2 – INTERMEDIATE PIPELINE
############################

#Multiple pipeline steps
Get-Process | Where-Object { $_.CPU -gt 5 } | Sort-Object CPU -Descending

#Top results after sorting
Get-Process | Sort-Object WorkingSet -Descending | Select-Object -First 5

#Expand property values
Get-Service | Select-Object -ExpandProperty Name

#Group objects
Get-Service | Group-Object Status

#Save pipeline output
Get-Process | Select-Object Name, Id | Export-Csv processes.csv -NoTypeInformation


############################
#LEVEL 3 – ADVANCED PIPELINE
############################

#Calculated properties
Get-Process | Select-Object Name, @{Name="MemoryMB";Expression={ $_.WorkingSet / 1MB }}

#Pipeline with conditional logic
Get-Process | ForEach-Object {
    if ($_.CPU -gt 10) {
        $_.Name
    }
}

#Chain filtering + sorting + selecting
Get-Service | Where-Object { $_.Status -eq "Running" } | Sort-Object Name | Select-Object Name, Status

#Search inside file content
Get-Content .\log.txt | Where-Object { $_ -match "error" }

#Compare two object sets
$A = Get-Service
$B = Get-Process
Compare-Object $A $B


############################
#LEVEL 4 – REAL-WORLD PIPELINE
############################

#Find top 5 high CPU processes and export
Get-Process | Sort-Object CPU -Descending | Select-Object -First 5 Name, CPU | Export-Csv topcpu.csv -NoTypeInformation

#Stop specific processes safely
Get-Process | Where-Object { $_.Name -like "note*" } | Stop-Process -WhatIf

#Get running services and save report
Get-Service | Where-Object { $_.Status -eq "Running" } | Select-Object Name | Out-File running_services.txt

#Monitor log file for errors
Get-Content .\log.txt | Select-String "error"

#Convert output to HTML report
Get-Process | Select-Object Name, CPU | ConvertTo-Html | Out-File report.html

#Display + save output using Tee-Object
Get-Process | Tee-Object -FilePath allprocess.txt