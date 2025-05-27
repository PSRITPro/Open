<#
Parameters can be optional or required. If a parameter is required, and you run the cmdlet without providing a value 
for that parameter, Windows PowerShell prompts you to provide a value for it. For example, 
if you run the command Get-Item, you receive the following message from Windows PowerShell, 
which includes a prompt to provide a value for the -Path parameter:

PS C:\> Get-Item cmdlet Get-Item at command pipeline position 1 Supply values for the following parameters: Path[0]:


If you enter the text C:\ at the prompt and then press the Enter key twice, the command runs successfully. 
You must press the Enter key twice because this parameter can accept multiple values. Windows PowerShell continues prompting for 
a new value until you press the Enter key without actually providing it.
#>