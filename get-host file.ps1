function get-hostinfo
{
    [cmdletbinding ()]
    param(
    [parameter(mandatory=$true,valuefrompipeline=$true, valuefrompipelinebypropertyname=$true)]
    [string []] $dnshost 
    )
    
$os=Get-CimInstance -ClassName Win32_OperatingSystem 
$suptime= $os.LocalDateTime - $os.LastBootUpTime
$disk = Get-CIMInstance -class Win32_logicaldisk -filter "DeviceID='C:'"
$properties= [ordered]@{
             'hostname'= $dnshost;
             'os'=$os.caption;
             'lastboottime'=$os.LastBootUpTime;
             'uptimehours'=$suptime;
             'c_c_gb_freespace'=($disk.FreeSpace / 1gb -as [int])
             }
             $obj = New-Object -TypeName psobject -Property $properties 
             write-output $obj

}

get-hostinfo -dnshost lon-dc1