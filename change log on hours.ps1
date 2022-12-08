<# 
.Synopsis 
Used for changing log on hours to multiple USers in an OU.
.Description

#>

$template_user='clex'
$template_hours= Get-ADUser -Identity $template_user -properties logonHours
$OU = Get-ADOrganizationalUnit -filter 'name -like "_TempNEWRecruits"' 
Get-aduser  -Filter * -SearchBase $OU |foreach {Set-ADUSer $_.samaccountname -Replace @{logonHours = $template_hours.logonHours} }