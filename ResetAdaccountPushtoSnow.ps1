#import azure ad
Import-Module AzureAD
Import-Module ActiveDirectory
Import-Module MSOnline
#reseting varibles
$uname = $null
$AzureAdCred = $null
$umail = $null
$guid = $null
$nP1 = $null
$response = $null


#login
$AzureAdCred = Get-Credential
Connect-AzureAD -Credential $AzureAdCred
Connect-AzAccount -Credential $AzureAdCred
Connect-SPOService -Url https://<sub>.sharepoint.com -Credential $AzureAdCred

#userprompt
$uname = Read-Host -Prompt 'Enter AD Username Playa!!'

#get email and GUID for Azure
$umail = (get-aduser $input).UserPrincipalName
$guid = (Get-AzureADUser -SearchString $umail).ObjectId

#reset local ad
##randomvalue
$gen1 = -join ((33..126) | Get-Random -Count 16 | % {[char]$_})
$nP1 = ConvertTo-SecureString -String $gen1 -Force -AsPlainText
#Local AD reset  
Set-ADAccountPassword -Identity $input -Reset -NewPassword $nP1 
#Azure reset
Set-AzureADUserPassword -ObjectId $guid -Password $nP1

#kill sessions
Revoke-AzureADUserAllRefreshToken -ObjectId $guid
Revoke-SPOUserSession -User $umail

#Service NOW
# Build auth header
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $AzureAdCred.UserName, $AzureAdCred.GetNetworkCredential().Password)))

# Set proper headers
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add('Authorization',('Basic {0}' -f $base64AuthInfo))
$headers.Add('Accept','application/json')
$headers.Add('Content-Type','application/json')

# Specify endpoint uri
$uri = "https://<sub>.service-now.com/api/now/table/incident"

# Specify HTTP method
$method = "post"

# Specify request body
$body = @"
{"short_description":"$umail has been compromised","caller_id":"<sn_name>","description":"$umail has been compromised, please contact the user to reset their password and enforce MFA","location":"<loc>","contact_type":"Phone","u_contact_email_address":"<email>","category":"Software","subcategory":"Email","impact":"3","urgency":"1","state":"1","assignment_group":"Cyber Security","business_service":"<service>","u_contact_phone_number":"Skype"}

"@
# Send HTTP request
$response = Invoke-RestMethod -Headers $headers -Method $method -Uri $uri -Body $body

# Print response
#$response.result.number
#$response.result.short_description

$snowuri = "https://<subdomain>.service-now.com/nav_to.do?uri=%2Fincident.do%3Fsys_id%3D" + $response.result.sys_id
$finc = $response.result.number

#Email alert
$body = "The following account has been compromised and raised " + $finc
$body += "A ticket has been raised <a href='$snowuri'>$finc</a>"
Send-MailMessage -To <email> -from <email> -Subject 'Account Compromise: TEST TEST ' -Body $body -BodyAsHtml -smtpserver smtp.office365.com -usessl -Credential $AzureAdCred -Port 587 
