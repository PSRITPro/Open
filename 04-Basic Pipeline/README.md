In this session, we’re going to focus on the PowerShell Pipeline (|), one of the most powerful features of PowerShell. The pipeline allows you to pass the output of one cmdlet directly to the next cmdlet, enabling you to perform multiple tasks in a sequence without storing data temporarily.

# What is the Pipeline in PowerShell?

The pipeline in PowerShell is an integral part of scripting and automation. It enables data to be processed sequentially, with each cmdlet performing an action on the data it receives. The symbol | is used to chain multiple cmdlets together. It’s like a conveyor belt where data flows from one cmdlet to another, being transformed or filtered along the way.

#### Syntax of the PowerShell Pipeline:

"In PowerShell, the basic syntax for the pipeline is simple. You use the | symbol to link cmdlets together."

Basic Syntax:
```powershell
<cmdlet1> | <cmdlet2> | <cmdlet3> ...
```
Explanation:

- cmdlet1 produces some output.
- | pipes this output to the next cmdlet.
- cmdlet2 performs an action on that output.
- The output of cmdlet2 is passed to cmdlet3, and so on.


Examples with Multiple Cmdlets:

```powershell
Get-Service | Where-Object {$_.Status -eq "Running"} | Sort-Object Name
```
Explanation:

    One of the key features of PowerShell’s pipeline is that it passes objects between commands, not just raw text. Each object contains properties and methods that can be used by the receiving cmdlet.
    For example, Get-Service doesn't just send the names of files as text, but rather it sends file objects that have properties like Name, Staus, serviceType etc.

    $_ (The Pipeline Variable): When an object is passed through the pipeline, it’s represented by the automatic variable $_. This is a reference to the current object being processed by the pipeline. $_ refers to each individual service in the list of services being processed by Where-Object.
    
---
Advanced Pipeline Usage:

Example 1: Filtering and Formatting Data
- You can filter data and format it using the pipeline.

```powershell
Get-Service | Where-Object {$_.Status -eq "Running"} | Select-Object Name, Status
```

Example 2: Sorting Data

- The pipeline is also very useful for sorting data.

```powershell
Get-EventLog -LogName System | Sort-Object TimeGenerated -Descending | Select-Object -First 5
```

Example 3: Exporting Data

- You can even export data to a file with the pipeline.

```powershell
Get-Service | Where-Object {$_.Status -eq 'Stopped'} | Export-Csv "stopped_services.csv"
```

Example 4: Get file content

```powershell
Get-Item "E:\GitHub\sptrains\my-learning-journal\PowerShell\Day4\README.md" -ErrorAction SilentlyContinue | Get-Content
```

---
### Benefits of Using the PowerShell Pipeline

1. Simplifies Automation:

Pipeline makes automation simpler. Instead of writing multiple lines of code, you can chain cmdlets together in a single line. Each cmdlet processes the output of the previous one, performing the necessary actions efficiently. This minimizes complexity and reduces the need for intermediate steps.

2. Improves Efficiency:

The pipeline also improves efficiency. By passing data directly between cmdlets, you don’t need to store intermediate results in variables or temporary files. This reduces memory usage and speeds up processing.

Instead of creating separate variables or files to hold the output of each cmdlet, data flows directly from one cmdlet to the next. This makes the entire process faster and more efficient.

3. Real-Time Processing

Another benefit is real-time processing. The pipeline allows data to be processed immediately as it flows through each cmdlet. This means you don’t have to wait for the entire dataset to be gathered before starting the processing. This is particularly useful when working with large datasets.

Example: "When you retrieve system logs or file lists, PowerShell starts processing the data as it’s being received, ensuring quicker results."

4. Reduces Code Complexity

One of the key advantages of the pipeline is that it helps reduce code complexity. With the pipeline, you can perform complex tasks in fewer lines of code, making your scripts more concise and easier to read. This not only saves time but also makes your scripts more maintainable.

5. Increases Flexibility



The pipeline gives you flexibility when working with different types of objects. Whether you’re working with files, services, processes, or strings, the pipeline allows you to filter, sort, and transform the data according to your needs.