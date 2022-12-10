<# 
.synopsis
Initialize raw disks, partition, and format volumes
.Description
Currently script works with single drives perfectly. Keep in mind if you have
multiple raw drives, the script will turn them all on and format. 
If you dont care about that then you need to worry about the newfilesystemlabel.
The newfilesystemlabel string will be for all disk drives and will not assign disk numbers
currently trying to figure out this problem. #>
<#Get-Disk |

Where partitionstyle -eq ‘raw’ |

Initialize-Disk -PartitionStyle MBR -PassThru |

New-Partition -AssignDriveLetter -UseMaximumSize |

Format-Volume -FileSystem NTFS -NewFileSystemLabel “disk” -Confirm:$false
#>



<# This is tested using Course 20740C Lab 2 on LON-SVR1.
LON-SVR1 Disk #'s 4 thru 10 are 'RAW'

$label = $disk.number gets the disk # for each drive using the "Number" property on the drive and
since it is an [INT] it needs to be converted to a string to use as text in -NewFileSystemLabel
#>

#Populate array $RawDisks
$RawDisks = Get-Disk | Where-Object partitionstyle -eq 'RAW'

FOREACH ($disk in $RawDisks) {
    $label = $disk.number -as [string]
    Initialize-Disk -Number $label -PartitionStyle MBR 
    New-Partition -DiskNumber $label -AssignDriveLetter -UseMaximumSize | 
    Format-Volume -FileSystem NTFS -NewFileSystemLabel "Disk $label" -Confirm:$false
}

<# 
You can use the following Code to RESET disks #'s 4-10 bak to back to 'RAW' for testing the code multiple times

For($i=4;$i -le 10;$i++)
{Clear-disk -Number $i -RemoveData  -Confirm:$false}

#>