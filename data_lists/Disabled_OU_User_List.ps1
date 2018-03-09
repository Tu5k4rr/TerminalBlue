<#
  Version:1.0
  Author:@Tu5K4rr
  Purpose:Create list of users who are in the disabled/company leavers OU group
  Usage: Check for accounts being re-enabled
  Note: Please add in your domain path for group to be pulled using Get-ADUser	
  Test Platform: Tested and works with Logrhythm Platform Manager Windows server (Server 2012 R2)
#>

# Delete existing file
﻿Remove-Item -Path C:\Scripts\disabledouList.txt
# Pull User list
Get-ADUser -SearchBase 'OU= DC PAth'  -Searchscope Subtree -Filter * | Select samAccountName > "C:\Scripts\disabledouList.txt"
#Time Sleeper to allow population before copying over when running as a windows task.
Start-Sleep -Seconds 120
# Delete file in SIEM Path
Remove-Item -Path C:\SIEM\List_DIR\disabledouList.txt
#Copy Over new file to SIEM PATH
Copy-Item "C:\Scripts\disabledouList.txt" -Destination C:\SIEM\List_DIR\disabledouList.txt

