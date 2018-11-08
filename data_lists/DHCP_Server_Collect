Get-DhcpServerv4lease -ScopeId <0.0.0.0>| select Hostname,AddressState | % {$_.Hostname} | % {$_.AddressState -lt "InactiveReservation"} > DHCP_1ST.txt 
  Select-String -Path DHCP_YES.txt -Pattern 'UK-|US-|SVR-' -NotMatch | Format-Table -Property Line > DHCP_COMP.txt
