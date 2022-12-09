<# 
.Synopsis 
Used for changing log on hours to multiple USers in an OU.
#>

$template_user='clex'
$template_hours= Get-ADUser -Identity $template_user -properties logonHours
$OU = Get-ADOrganizationalUnit -filter 'name -like "_TempNEWRecruits"' 
Get-aduser  -Filter * -SearchBase $OU |foreach {Set-ADUSer $_.samaccountname -Replace @{logonHours = $template_hours.logonHours} }

#PROBLEM I had at first was the foreach loop actully get every user in the OU. Realized that I needed to change the get-roganizationlunit 
# into Get-aduser and filter. Also had to make $OU variable#