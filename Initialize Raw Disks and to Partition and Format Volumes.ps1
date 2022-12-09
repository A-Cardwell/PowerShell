<# 
.synopsis
Initialize raw disks, partition, and format volumes
.Description
Currently script works with single drives perfectly. Keep in mind if you have
multiple raw drives, the script will turn them all on and format. 
If you dont care about that then you need to worry about the newfilesystemlabel.
The newfilesystemlabel string will be for all disk drives and will not assign disk numbers
currently trying to figure out this problem. #>

Get-Disk |

Where partitionstyle -eq ‘raw’ |

Initialize-Disk -PartitionStyle MBR -PassThru |

New-Partition -AssignDriveLetter -UseMaximumSize |

Format-Volume -FileSystem NTFS -NewFileSystemLabel “disk” -Confirm:$false