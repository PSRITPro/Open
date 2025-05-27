# PowerShell Training Program

Welcome to the **PowerShell Training Program**! This course is designed to help you learn PowerShell from the basics to advanced topics, with a strong emphasis on automation, system administration, and scripting. By the end of this course, you will be equipped with the knowledge and skills to effectively automate tasks and manage configurations using PowerShell.

## Table of Contents

- [Introduction](#introduction)
- [Week 1: Introduction to PowerShell](#week-1-introduction-to-powershell)
  - [Day 1: Introduction to PowerShell](#day-1-introduction-to-powershell)
- [Week 2: Intermediate Commands and Scripting](#week-2-intermediate-commands-and-scripting)
- [Week 3: Advanced Scripting and Automation](#week-3-advanced-scripting-and-automation)
- [Week 4: Advanced Topics and Best Practices](#week-4-advanced-topics-and-best-practices)
- [Capstone Project](#capstone-project)

---

## Introduction

PowerShell is a powerful task automation framework that combines a command-line shell with a scripting language. It is designed primarily for system administration and DevOps professionals to automate tasks, manage configurations, and interact with various systems, services, and APIs. This training will take you from the basics to advanced PowerShell usage, covering key concepts like cmdlets, functions, automation, remoting, and more.

---

## Week 1: Introduction to PowerShell

### Day 1: Introduction to PowerShell

#### Overview of PowerShell

PowerShell is both a **command-line shell** and a **scripting language** designed for automating administrative tasks. It provides a rich set of tools for interacting with your operating system, managing system configurations, and automating repetitive tasks.

#### Key Concepts:
1. **Cmdlets**: These are PowerShell commands used for various tasks such as managing processes, files, and system services. Cmdlets follow a consistent verb-noun format, such as `Get-Process`, `Set-Location`, and `Remove-Item`.

2. **Pipelines**: PowerShell allows you to send the output of one cmdlet as input to another cmdlet through **pipelines**. This enables you to chain commands together for more complex operations.

3. **Objects**: PowerShell deals with objects, not just text output. This makes it easier to filter and manipulate data, especially when working with system resources like processes or services.

4. **Cross-Platform Support**: With the introduction of PowerShell Core, PowerShell is now available on Windows, macOS, and Linux, making it a versatile tool for system administrators.

5. **Environment**: PowerShell can be used via the standard PowerShell console, PowerShell ISE (Integrated Scripting Environment), or Visual Studio Code (VSCode) for advanced editing and debugging.

#### PowerShell vs Other Shells

| Feature                    | **PowerShell**                                   | **Command Prompt (cmd.exe)**                     | **Bash**                                         |
| -------------------------- | ------------------------------------------------ | ------------------------------------------------ | ------------------------------------------------ |
| **Type**                    | Object-oriented shell and scripting language     | Text-based command-line interface                | Text-based shell with scripting capabilities     |
| **Output Format**           | Objects (easily manipulated)                    | Text (limited processing)                        | Text (often piped into other text-based commands)|
| **Automation Support**      | Extensive automation with cmdlets and scripts    | Basic scripting support (batch files)            | Extensive scripting support (Bash scripts)       |
| **Platform Support**        | Cross-platform (Windows, macOS, Linux)          | Primarily Windows                               | Linux/Unix, macOS (with some Windows support via WSL)|
| **Integration**             | Deep integration with Windows, .NET, Azure, and more | Limited integration with Windows features        | Integrated with Linux tools and utilities       |
| **Learning Curve**          | Moderate to High (due to cmdlets, objects, etc.) | Low (simple text-based commands)                 | Moderate (due to scripting capabilities)         |

---

### Day 1 Learning Objectives:
By the end of Day 1, you should be able to:
- Understand what PowerShell is and how it compares to other command-line tools.
- Get familiar with the PowerShell environment (console, ISE, VSCode).
- Learn basic PowerShell commands (cmdlets) and how they work.
- Understand the concept of pipelines and how PowerShell handles objects.
- Begin using PowerShell to automate simple tasks.

---

### Day 1 Practical Exercise:

1. **Exploring Cmdlets**:
   - Open PowerShell and run the command `Get-Command` to list all available cmdlets.
   - Try out the `Get-Process`, `Get-Service`, and `Get-Help` cmdlets to explore their output and functionality.

2. **Help System**:
   - Use the `Get-Help` cmdlet to get more information about any cmdlet. For example: `Get-Help Get-Process`.
   - Try using the `Get-Command` cmdlet to list commands and then explore each one with `Get-Help`.

3. **Environment Exploration**:
   - Launch the PowerShell ISE or VSCode, and explore how the interfaces differ from the standard PowerShell console.
   - Try running basic commands in each environment and compare the experiences.

---

### Additional Resources:
- [PowerShell Documentation](https://learn.microsoft.com/en-us/powershell/)
- [PowerShell Cmdlets Reference](https://learn.microsoft.com/en-us/powershell/scripting/overview)

---

## Week 2: Intermediate Commands and Scripting

### Day 8: Functions

---

## Capstone Project

By the end of the course, you will complete a **Capstone Project** that will challenge you to apply everything you’ve learned throughout the program. Example projects include:
- Automating system health checks across multiple machines
- Creating a script to deploy and configure an application
- Automating server patch management tasks

---

**Thank you for joining the PowerShell Training Program!** If you have any questions or feedback, feel free to contact us at [Your Contact Information].

---

