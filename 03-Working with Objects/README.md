# Working with Objects

## Overview
PowerShell is an **object-oriented** scripting language, not just a text-based shell. In PowerShell, **everything is an object**—whether it's a file, process, service, string, or other system resources. Each object has **properties** (data) and **methods** (actions) that you can interact with.

By treating data as objects, PowerShell enables you to efficiently manipulate and manage system resources, providing greater flexibility in automating tasks and controlling system behavior.

---

### Let’s use an **Apple** as an example to better understand how objects, properties, and methods work in PowerShell:

The **Apple** object has two essential components:  
- **Properties** (e.g., Color, Shape, Skin) that describe the apple,  
- **Methods** (e.g., Eat, Peel) that represent actions you can perform on the apple.

### **Properties**:
Properties are the characteristics or attributes that describe an object. They are fundamental to understanding and working with objects, providing essential information about their state. Properties allow you to access specific details about an object, such as its **Color**, **Shape**, **Size**, or **Status**, and help you manipulate or filter objects based on these characteristics.

In PowerShell, properties can be used to gather data about various system resources, such as **files**, **services**, and **processes**. By examining the properties of these objects, you can automate tasks and gain insights into the current state of your system.

Properties can be accessed or modified through PowerShell cmdlets, allowing you to automate tasks, query system information, and filter or sort data based on these properties. This makes PowerShell a powerful tool for managing and interacting with system resources.

**Example of Apple Properties**:  
- **Color**: Green  
- **Shape**: Round  
- **Skin**: Edible  

### **Methods**:
Methods are the actions you can perform on the object. Methods in PowerShell provide ways to interact with and manipulate objects. Just as you can "eat" or "peel" an apple, you can perform actions like read, write, or delete on objects like files, or start, stop, or restart services.

**Example of Apple Methods**:  
- **Eat**: You can eat the apple.  
- **Peel**: You can peel the apple.

### Conclusion:
Whether you are working with files, services, or processes, understanding **object properties** and **methods** is key to automating tasks and managing system resources efficiently in PowerShell.

---

### Exploring and Selecting Object Properties:

1. Using **`Get-Member`** to Discover Object Properties
The Get-Member cmdlet is the primary cmdlet for discovering the properties and methods of any object. When you pipe an object into Get-Member, it returns a list of available properties (data fields) and methods (actions).

2. Using **`Select-Object`** to Filter Properties
Once you discover the properties of an object using `Get-Member`, you can use the `Select-Object` cmdlet to display only the properties you are interested in. This cmdlet allows you to extract a subset of properties for easier analysis or processing.

3. Using **`Format-List`** cmdlet displays all properties of an object in a detailed list format. It is useful when you want to see every available data field for an object, especially when dealing with objects that have many properties.

----

## Examples

The **`Get-Member`** cmdlet is essential for exploring the properties and methods of objects in PowerShell. By passing an object to `Get-Member`, you can view all of its properties (data) and methods (actions).

#### Example 1: Discover Properties of a Services Object

You can inspect the properties and methods of the services running on your system using the following PowerShell command:
```powershell
 Get-Services | Get-Member
```

Retrieves a list of all the services running on your system. Selects and displays only the Name and Status properties of each service.

```powershell
 Get-Service | Select-Object Name, Status
```

In PowerShell, you can retrieve a list of services on your system, select specific properties like `Name` and `Status`, and then use the `Get-Member` cmdlet to discover what properties and methods are available for those objects.

```powershell
 Get-Service | Select-Object Name, Status | Get-Member
```
#### Example 2: Discover Properties of a File Object

In PowerShell, you can use the `Get-Item` cmdlet to retrieve the properties of a file and pipe it into `Get-Member` to inspect the available properties and methods for that file object.

Here’s an example of how to get the properties of a file (such as `readme.md`):


```powershell
Get-Item "C:\path\to\readme.md"
```

```powershell
Get-Item "C:\path\to\readme.md" | Select-Object Name, Length, LastWriteTime
```

```powershell
Get-Item "C:\path\to\readme.md" | Get-Member
```

```powershell
Get-Item "C:\path\to\readme.md" | Select-Object Name | Get-Member
```

```powershell
Get-Item "C:\path\to\readme.md" | Select-Object Name | Get-Member |  Format-List
```

##### Renaming Properties in Output
```powershell
Get-Service | Select-Object @{Name="ServiceName";Expression={$_.Name}}, @{Name="ServiceStaus";Expression={$_.Status}}
```

```powershell
Get-Service | Select-Object @{Name="ServiceName";Expression={$_.Name}}, @{Name="ServiceStaus";Expression={$_.Status}} | Select -First 3
```