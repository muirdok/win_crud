Set-NetConnectionProfile -Name “mrdk” -NetworkCategory Private
set-item WSMan:\localhost\Client\TrustedHosts -Value "*"
winrm set winrm/config/service/auth '@{CredSSP="true"}'
winrm set winrm/config/client/auth '@{CredSSP="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/Client '@{AllowUnencrypted = "true"}'
winrm set winrm/config/Service '@{AllowUnencrypted = "true"}'