# Basic Commands

## Objectives
By the end of this sessoin, you will:
- Understand the basic structure of PowerShell commands.
- Learn how to execute commands using cmdlets.
- Familiarize yourself with common cmdlets and their usage.

## Command Structure
PowerShell commands follow a specific syntax and structure. The basic structure of a command in PowerShell is:

```plaintext
<Verb>-<Noun> [-Parameter <Value>]
```
# Understanding PowerShell Commands

PowerShell commands, also known as **cmdlets**, follow a specific naming convention that includes a verb and a noun. Additionally, parameters can be used to modify the behavior of these commands.

## Components of PowerShell Cmdlets

### Verb

The **verb** specifies the action you want to perform. Common verbs include:

- **Get**: Retrieves information.
- **Set**: Modifies existing information.
- **New**: Creates a new resource.
- **Remove**: Deletes a resource.

### Noun

The **noun** indicates the resource you want to work with. Examples include:

- **Process**: Refers to running processes on the system.
- **Service**: Represents Windows services.
- **User**: Indicates user accounts on the system.

### Parameter

Parameters are additional options that modify the behavior of the command. They allow you to specify conditions, inputs, and other options to tailor the cmdlet to your needs.

### Example

A complete cmdlet might look like this:

```powershell
Get-Process -Name "notepad"
```

In this command:

- Get is the verb (to retrieve).
- Process is the noun (the resource being retrieved).
- -Name "notepad" is a parameter that specifies which process to retrieve.

### Executing Commands
To execute a command in PowerShell, simply type it into the PowerShell console and press Enter.

Example Commands:

1.   **Get Help on a Command**
        ```powershell
        Get-Help Get-Process
        ```
       *    Displays detailed information about the Get-Process cmdlet, including syntax, parameters, and examples.

2.  **List All Available Cmdlets**
    ```powershell
    Get-Command
    ```
    *   This command lists all cmdlets available in your current session, including aliases and functions.

3.  **Get a List of Running Processes**
    ```powershell
    Get-Process
    ```
    *   Retrieves a list of all currently running processes on the local machine.

4.  **Filter Processes by Name**
    ```powershell
    Get-Process
    ```
    *   Retrieves the process information for all instances of PowerShell running on the system.

5.  **Get System Information**
    ```powershell
    Get-ComputerInfo
    ```
    *   Displays detailed information about the computer’s hardware and operating system.

6.  **Change Directory**
    ```powershell
    Set-Location -Path "C:\Program Files"

    ```
    *   Changes the current working directory to "C:\Program Files".

7.  **Create a New Directory**
    ```powershell
    New-Item -ItemType Directory -Name "TestFolder"
    ```
    *   Creates a new directory named "TestFolder" in the current location.

8.  **List Files in a Directory**
    ```powershell
    Get-ChildItem
    ```
    *   Lists all files and folders in the current directory.

9.  **Display Current Directory**
    ```powershell
    Get-Location
    ```
    *   Shows the path of the current working directory.

10. **Remove a File**
    ```powershell
    Remove-Item -Path "C:\Temp\TestFile.txt"
    ```
    *   Deletes the file "TestFile.txt" from the "C:\Temp" directory.

### Using Parameters
Parameters can often be abbreviated to make commands quicker to type. For example, -Name can be shortened to -N.
```powershell
Get-Process -N "notepad"
```

### Using Aliases
PowerShell supports aliases, which are shortcuts for cmdlets.

#### Common Aliases:
-   gci for Get-ChildItem
-   ls for Get-ChildItem
-   dir for Get-ChildItem
-   gps for Get-Process

    *   Example:
        ```powershell
        gci
        ```
        This command will list the contents of the current directory, just like Get-ChildItem.

### Pipelining Commands
PowerShell allows you to pipe the output of one command as the input to another using the pipe operator (|).

*   Example:
    ```powershell
        Get-Process | Where-Object { $_.CPU -gt 100 } | Sort-Object CPU -Descending
    ```
    In this command:
    -   Get-Process retrieves all running processes.
    -   Where-Object { $_.CPU -gt 100 } filters processes using the CPU greater than 100.
    -   Sort-Object CPU -Descending sorts the filtered processes by CPU usage in descending order.

## Conclusion
In this session, we learned the basic structure of PowerShell commands, how to execute them, and explored several commonly used cmdlets. We also learned about using parameters, aliases, and pipelining, which are essential for efficient PowerShell scripting. Familiarity with these commands will empower you to perform basic tasks in PowerShell efficiently. As We continue our PowerShell journey, we will build upon this foundation to explore more advanced topics.