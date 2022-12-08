function get-hostinfo
{
    [cmdletbinding ()]
    param(
    [parameter(mandatory=$true,valuefrompipeline=$true, valuefrompipelinebypropertyname=$true)]
    [string []] $dnshost 
    )


    Process{
   foreach($computer in $dnshost) {
$os=Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $computer
$suptime= $os.LocalDateTime - $os.LastBootUpTime
$disk = Get-CIMInstance -class Win32_logicaldisk -filter "DeviceID='C:'"
$properties= [ordered]@{
             'hostname'= $computer;
             'os'=$os.caption;
             'lastboottime'=$os.LastBootUpTime;
             'uptimehours'=$suptime;
             'c_c_gb_freespace'=($disk.FreeSpace / 1gb -as [int])
             }
             $obj = New-Object -TypeName psobject -Property $properties 
             write-output $obj
             $obj | Select-Object -Property hostname, os, lastbootime,uptimehours,c_gb_freespace | export-csv -path C:\test.csv -NoTypeInformation -Append
             }
                     }
}

get-hostinfo -dnshost lon-dc1, lon-cl1, lon-svr1