#Get All Verbs
Get-Verb

#Count All Verbs
(Get-Verb).Count



#Get specific verb details
Get-Verb -Verb Set

#Get group of verbs details

Get-Verb -Group Security

#Get output in formated list

Get-Verb -Group Security | Format-List



#Installing Help content
#Update-Help -Module Microsoft.PowerShell*

#Explore abute parameters

Get-Help about_commonparameters

Get-Service -Name AJRouter

Get-Service -Name AppIDSvc


Get-Service -Name Spooler -RequiredServices

Get-Service -Name Spooler -RequiredServices -DependentServices