---
external help file: ServerManagementTools-help.xml
online version: https://github.com/twillin912/ServerManagementTools
schema: 2.0.0
---

# Get-DfsrBacklogStatus

## SYNOPSIS
Retrieves the count of pending file updates between two DFS Replication partners.

## SYNTAX

```
Get-DfsrBacklogStatus [[-ComputerName] <String[]>] [[-FolderName] <String[]>] [<CommonParameters>]
```

## DESCRIPTION
The Get-DfsrBacklogStatus cmdlet retrieves a count of pending updates between two computers that participate in Distributed File System (DFS) Replication.

Updates can be new, modified, or deleted files and folders. 
Any files or folders listed in the DFS Replication backlog have not yet replicated from the source computer to the destination computer.
This is not necessarily an indication of problems.
A backlog indicates latency, and a backlog may be expected in your environment, depending on configuration, rate of change, network, and other factors.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-DfsrBacklogStatus -ComputerName 'MyServer'
```

Retrieves all configured replicated folders and their inbound backlog from each partner.

### -------------------------- EXAMPLE 2 --------------------------
```
Get-DfsrBacklogStatus -ComputerName 'MyServer' -FolderName 'Folder01'
```

Retrieves the replicated folder 'Folder01' and its inbound backlog from each partner.

## PARAMETERS

### -ComputerName
Specifies the name of the sending computer.
A source computer is also called an outbound or upstream computer.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: Localhost
Accept pipeline input: False
Accept wildcard characters: False
```

### -FolderName
Specifies an array of names of replicated folders.
If you do not specify this parameter, the cmdlet queries for all participating replicated folders.
You can specify multiple folders, separated by commas.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Management.Automation.PSObject

## NOTES
Author: Trent Willingham
Check out my other projects on GitHub https://github.com/twillin912

## RELATED LINKS

[https://github.com/twillin912/ServerManagementTools](https://github.com/twillin912/ServerManagementTools)

