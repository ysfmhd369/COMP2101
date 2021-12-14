"System Information Script"
#Going to print system hardware description
"System Hardware description"
Get-WmiObject win32_computersystem | Select-Object Manufacturer,model,name,primaryownername | Format-List
"___________________________"
#Going to print operating system name and version number"
"Printing Operating system name and version number"
if ((Get-WmiObject win32_operatingsystem).caption -ne "")
{
"Operating system name= " + (Get-WmiObject win32_operatingsystem).caption
}
if ((Get-WmiObject win32_operatingsystem).version -ne "")
{
"System version= " + (Get-WmiObject win32_operatingsystem).version
}
"________________________________"
#Commands for printing processor description with speed, number of cores, and sizes of L1, L2, and L3 caches if they are present (win32_processor)
"Printing processor description"
if ((Get-WmiObject win32_processor).caption -ne "")
{
"Description= " + (Get-WmiObject win32_processor).caption
}
if ((Get-WmiObject win32_processor).name -ne "")
{
"Type of processor with speed = " + (Get-WmiObject win32_processor).name
}
if ((Get-WmiObject win32_processor).numberofcores -ne "")
{
"NUmber of cores = " + (Get-WmiObject win32_processor).numberofcores
}
if ((Get-WmiObject win32_processor).L1CacheSize -ne "")
{
"L1 Cache size= " + (Get-WmiObject win32_processor).L1CacheSize
}
if ((Get-WmiObject win32_processor).L2CacheSize -ne "")
{
"L2 Cache size= " + (Get-WmiObject win32_processor).L2CacheSize
}
if ((Get-WmiObject win32_processor).L3CacheSize -ne "")
{
"L3 Cache size= " + (Get-WmiObject win32_processor).L3CacheSize
}
"__________________________________________"
#commands for prinding summary of RAM
"Printing summary of RAM"
if ((Get-WmiObject Win32_physicalmemory).description -ne "")
{
"Name = " + (Get-WmiObject Win32_physicalmemory).description
}
if ((Get-WmiObject Win32_physicalmemory).manufacturer -ne "")
{
"Vendor = " + (Get-WmiObject Win32_physicalmemory).manufacturer
}
if ((Get-WmiObject Win32_physicalmemory).capacity/1Gb -ne "")
{
"Memmory = " + (Get-WmiObject Win32_physicalmemory).capacity/1Gb + "Gb"
}
if ((Get-WmiObject Win32_physicalmemory).banklabel -ne "")
{
" Bank label= " + (Get-WmiObject Win32_physicalmemory).banklabel
}
if ((Get-WmiObject Win32_physicalmemory).totalphysicalmemory -ne "")
{
"Total RAM installed= " + (Get-WmiObject Win32_physicalmemory).totalphysicalmemory/1Gb + "Gb"
}
"______________________"
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
#Commands for network configuration summary"
"Printing summary of network adapter"
 if ((Get-CimInstance win32_networkadapterconfiguration).description -ne "")
{
"Description= " + (Get-CimInstance win32_networkadapterconfiguration).description
}
if ((Get-CimInstance win32_networkadapterconfiguration).index -ne "")
{
"Index= " + (Get-CimInstance win32_networkadapterconfiguration).index
}
if ((Get-CimInstance win32_networkadapterconfiguration).ipaddress -ne "" )
{
"IP address= " + (Get-CimInstance win32_networkadapterconfiguration).ipaddress
}
if ((Get-CimInstance win32_networkadapterconfiguration).IPSubnet -ne "" )
{
"Subnet mask = " + (Get-CimInstance win32_networkadapterconfiguration).IPSubnet
}
if ((Get-CimInstance win32_networkadapterconfiguration).DNSDomain -ne "")
{
"DNS domain = " + (Get-CimInstance win32_networkadapterconfiguration).DNSDomain
}
if ((Get-CimInstance win32_networkadapterconfiguration).DNSHostName -ne "")
{
"DNS hostname= " + (Get-CimInstance win32_networkadapterconfiguration).DNSHostName
}
"___________________________________________________"
#Commands for prnting video card details
"Printing summary of video card"
if ((Get-WmiObject Win32_videocontroller).manufacturer -ne "")
{
"manufacturer = " + (Get-WmiObject Win32_videocontroller).manufacturer
}
if ((Get-WmiObject Win32_videocontroller).description -ne "")
{
"description= "+ (Get-WmiObject Win32_videocontroller).description
}
if ((Get-WmiObject Win32_videocontroller).videomodedescription -ne "")
{
"Resolution = " + (Get-WmiObject Win32_videocontroller).videomodedescription
}
"_______________________________"
"The End Of the Report"