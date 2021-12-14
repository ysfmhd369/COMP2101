#command for printing system hardware description
"Printing system hardware description"
Get-WmiObject win32_computersystem | Format-List
"________________________"
#commands for printing operating system details
"Printing operating system detais"
Get-WmiObject win32_operatingsystem|Select-Object caption, version|Format-Table
"________________________________"
#Commands for printing processor details
"Printing processor details"
Get-CimInstance -ClassName cim_processor | Format-List name, numberofcores,
@{n= "L1CacheSize"; e= {switch ($_.L1CacheSize) { $null { $output = "L1 cache size does not exist"} default {$output = $_.L1CacheSize } }; $output } },
@{n= "L2CacheSize"; e= {switch ($_.L2CacheSize) { $null { $output = "L2 cache size does not exist"} default {$output = $_.L2CacheSize } }; $output } },
@{n= "L3CacheSize"; e= {switch ($_.L3CacheSize) { $null { $output = "L3 cache size does not exist"} default {$output = $_.L3CacheSize } }; $output } }
"_________________________________"
#Command for printing RAM summary
"Printing RAM summary"
Get-WmiObject win32_physicalmemory | Select-Object description, manufacturer, capacity, banklabel, totalphysicalmemory
"________________________________"
# Commands for printing summary of physical drives
"Printing summary of physical drive"
$diskdrives = Get-CimInstance cim_diskdrive
foreach ($disk in $diskdrives)
{
$partitions = $disk|Get-CimAssociatedInstance -resultclassname cim_diskpartition
foreach ($partition in $partitions )
{
$logicaldisks = $partition | Get-CimAssociatedInstance -ResultClassName cim_logicaldisk
foreach ($logicaldisk in $logicaldisks)
{
New-Object -TypeName psobject -Property @{Manufacturer=$disk.Manufacturer
                                          Location=$partition.deviceid
                                          Drive=$logicaldisk.deviceid
                                          "Size(GB)"=$logicaldisk.size/1gb -as [int]
                                          "Freespace(GB)"=$logicaldisk.freespace/1gb -as [int]
                                          "Percentage free (%)"= 100*($logicaldisk.freespace)/($logicaldisk.size + $logicaldisk.freespace)
                                          }|Format-Table
}
}
}
"____________________________"
#Section for printing network adapter configuration
"Printing network adapter summary"
Get-CimInstance win32_networkadapterconfiguration | where-object ipenabled | Select-Object description, index, ipaddress, ipsubnet, dnsdomain, dnshostname|Format-Table
"_______________________________"
#command for printing videocard summary
"Printing video card summary"
Get-WmiObject win32_videocontroller | Select-Object name, description, videomodedescription | Format-Table
"___________________________________"
"_____END_____OF__________REPORT"