#First Example in PowerShell
# Hello World --> Try first without quatation

"Hello World"

Write-Host "Hello World"

#Get PS drive
Get-PSDrive 

#Get current location
Get-Location

#Get drive
(Get-Location).Drive


#another command to get drive for the current location 
Get-Location | Select-Object Drive

#Get current folder items
Get-ChildItem

#Get Services
Get-Service