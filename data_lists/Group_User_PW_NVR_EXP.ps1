<#
  Version:1.0
  Author:@Tu5K4rr
  Purpose:Create list for accounts on Active Directory whos passwords set to never exprire in a specified group. 
  Usage: group users.
  Note: Account audit
  Test Platform: Win10
#>


Get-ADGroupMember -identity "Corp Domain Admin Group" -Recursive | foreach{ Get-ADUser $_ -Properties *} 
| select SamAccountName, passwordNeverExpires | where {$_.passwordNeverExpires -eq "true"} | 
Format-Table -Property SamAccountName, passwordNeverExpires -AutoSize > C:\<path>
