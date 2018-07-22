##Lists acocunts on active directory passwords not required.


﻿get-aduser -filter * -properties Name, SamAccountName, PasswordNotRequired | where {$_.PasswordNotRequired -eq "true"} | where {$_.enabled -eq "true"} | Format-Table -Property Name, SAmAccountName, PasswordNotRequired -AutoSize > "PasswordNotRequired.txt"
