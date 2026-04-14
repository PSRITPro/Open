############################
#LEVEL 1 – BASIC VARIABLES
############################

#Create a variable
$name = "John"

#Display variable
$name

#Create numeric variable
$age = 25

#Display multiple variables
$name
$age

#String with variable
"Name is $name"


############################
#LEVEL 2 – VARIABLE TYPES
############################

#Integer variable
[int]$num = 10

#String variable
[string]$city = "Hyderabad"

#Boolean variable
[bool]$isActive = $true

#Array variable
$numbers = 1,2,3,4,5

#Display array
$numbers

#Access array element
$numbers[0]


############################
#LEVEL 3 – WORKING WITH VARIABLES
############################

#Get variable type
$num.GetType()

#Update variable value
$num = 20

#Arithmetic operations
$a = 10
$b = 5
$sum = $a + $b

#String concatenation
$first = "Hello"
$second = "World"
$result = "$first $second"

#Use variables in commands
Get-Process -Name $name


############################
#LEVEL 4 – ADVANCED VARIABLE USAGE
############################

#Environment variables
$env:PATH

#Create custom object variable
$person = [PSCustomObject]@{
    Name = "John"
    Age  = 30
}

#Access object properties
$person.Name

#Automatic variables
$PSVersionTable
$HOME
$PWD

#Null variable
$var = $null

#Check if variable is null
if ($var -eq $null) {
    "Variable is empty"
}

#Clear variable
Clear-Variable name

#Remove variable
Remove-Variable age