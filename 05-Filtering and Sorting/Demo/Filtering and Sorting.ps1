############################
#LEVEL 1 – BASIC FILTERING
############################

#Filter running services
Get-Service | Where-Object { $_.Status -eq "Running" }

#Filter stopped services
Get-Service | Where-Object { $_.Status -eq "Stopped" }

#Filter processes by name
Get-Process | Where-Object { $_.Name -eq "notepad" }

#Filter using -like (wildcard)
Get-Process | Where-Object { $_.Name -like "note*" }


############################
#LEVEL 2 – BASIC SORTING
############################

#Sort processes by CPU (ascending)
Get-Process | Sort-Object CPU

#Sort processes by CPU (descending)
Get-Process | Sort-Object CPU -Descending

#Sort services by name
Get-Service | Sort-Object Name

#Sort by multiple properties
Get-Service | Sort-Object Status, Name


############################
#LEVEL 3 – ADVANCED FILTERING
############################

#Filter using numeric condition
Get-Process | Where-Object { $_.CPU -gt 10 }

#Filter using multiple conditions
Get-Process | Where-Object { $_.CPU -gt 5 -and $_.WorkingSet -gt 100MB }

#Filter using -match (regex)
Get-Service | Where-Object { $_.Name -match "^W" }

#Filter using -notmatch
Get-Service | Where-Object { $_.Name -notmatch "^W" }

#Filter using -contains (arrays)
$names = "svchost","explorer"
Get-Process | Where-Object { $names -contains $_.Name }


############################
#LEVEL 4 – REAL-WORLD FILTERING & SORTING
############################

#Top 5 high CPU processes
Get-Process | Sort-Object CPU -Descending | Select-Object -First 5 Name, CPU

#Filter running services and sort by name
Get-Service | Where-Object { $_.Status -eq "Running" } | Sort-Object Name

#Filter processes and export report
Get-Process | Where-Object { $_.CPU -gt 10 } | Select-Object Name, CPU | Export-Csv highcpu.csv -NoTypeInformation

#Find specific logs containing error
Get-Content .\log.txt | Where-Object { $_ -match "error" }

#Sort and group services by status
Get-Service | Sort-Object Status | Group-Object Status

#Filter and stop processes safely
Get-Process | Where-Object { $_.Name -like "note*" } | Stop-Process -WhatIf

#Complex pipeline (filter + sort + select)
Get-Process | Where-Object { $_.WorkingSet -gt 200MB } | Sort-Object WorkingSet -Descending | Select-Object Name, WorkingSet