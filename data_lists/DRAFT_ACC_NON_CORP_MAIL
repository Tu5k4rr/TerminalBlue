<#
  Version:1.0
  Author:@Tu5K4rr
  Purpose:Show accounts with non standard corp e-mails assigned to.
  Usage: Find accounts with non-standard e-mail addresses.
  Note: Not completed, query works just tidying up results file.
  Test Platform: Win Server 2008 R2
#>
 
## Accounts with non corp e-mail
Get-ADUser -Filter * -Properties mail | where { $_.enabled -eq "true"} | where {$_.mail -eq "true"} > "no_mail.txt"
## Regex search for non-corp mail accounts and file input path
$inputpath = 'no_mail.txt'
$regex = '(\@corpmaildomain| \@corpmaildomain2 )' 
## Selecting regex to pattern match
select-string -Path $inputpath -Pattern $regex -NotMatch > 'no_corp_mail_res.txt'
## file tidy up insert here.
