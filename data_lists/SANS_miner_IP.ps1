<#
  Version:1.0
  Author:@Tu5K4rr
  Purpose:Convert XML to txt for SIEM IP list for miners
  Usage: Help detect for traffic against known miners
  Note: Thanks SANS for providing the XML data.
  Test Platform Windows Server 2012 R2
#>


# Wget file
wget https://isc.sans.edu/api/threatlist/miner -OutFile miner.xml
#select xml for input
$input_path = 'C:\Scripts\miner.xml'
# Set regex query
$regex = ‘\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b’
#process file with regex and output to txt
select-string -Path $input_path -Pattern $regex -AllMatches | % { $_.Matches } | % { $_.Value } > 'C:\Scripts\miner_ip.txt'
Copy-Item "C:\Scripts\miner_ip.txt" -Destination C:\SIEM\LIST


 
