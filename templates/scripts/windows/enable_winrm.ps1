$TranscriptPath = "C:\TEMP\enable_winrm.txt"
Write-Output "Starting PowerShell transcript to $($TrascriptPath)"
Start-Transcript -Path $TranscriptPath -Append -Force

Get-NetConnectionProfile | Set-NetConnectionProfile -NetworkCategory Private

# Disable firewall
Write-Output "---Disabling windows firewall"
Get-NetFirewallProfile | Set-NetFirewallProfile -Enabled False -PassThru -OutVariable Firewall | Select-Object Name, Enabled | Format-Table -AutoSize
foreach ($Profile in $Firewall) {
    if ($Profile.Enabled -eq "False") {
        Write-Output "---Windows firewall profile: $($($Profile).Name) is disabled."
    } elseif ($Profile.Enabled -eq "True") {
        Write-Output "---Windows firewall profile: $($($Profile).Name) is enabled."
    }
}

# Configure and Enable WinRM (HTTP and HTTPS)
Write-Output "---Enabling WinRM."
Remove-Item -Path WSMan:\Localhost\listener\listener* -Recurse
Write-Output "---Adding HTTP listener."
New-Item -Path WSMan:\LocalHost\Listener -Transport HTTP -Address * -Force
Write-Output "---Creating new serf signed certificate for WinRM HTTP listener."
$Cert = New-SelfSignedCertificate -CertstoreLocation Cert:\LocalMachine\My -DnsName "packer"
Write-Output "---Adding HTTPS listener."
New-Item -Path WSMan:\LocalHost\Listener -Transport HTTPS -Address * -CertificateThumbPrint $Cert.Thumbprint -Force

# Configure WinRM to allow unencrypted communication
winrm set "winrm/config/service" '@{AllowUnencrypted="false"}'
winrm set "winrm/config/client" '@{AllowUnencrypted="false"}'
winrm set "winrm/config/service/auth" '@{Basic="true"}'
winrm set "winrm/config/client/auth" '@{Basic="true"}'
winrm set "winrm/config/service/auth" '@{CredSSP="true"}'
Write-Output "---Listing listeners."
winrm enumerate winrm/config/listener
Write-Output "---Configuring firewall rules."
New-NetFirewallRule -Displayname 'WinRM - Powershell remoting HTTP-In' -Name 'WinRM - Powershell remoting HTTP-In' -Profile Any -LocalPort 5985 -Protocol TCP -Enabled True
New-NetFirewallRule -Displayname 'WinRM - Powershell remoting HTTPS-In' -Name 'WinRM - Powershell remoting HTTPS-In' -Profile Any -LocalPort 5986 -Protocol TCP -Enabled True

Write-Output "---Configuring WinRM service."
Stop-Service -Name WinRM
Set-Service -Name WinRM -StartupType Automatic
Restart-Service WinRM
Test-WSMan
Write-Output "---WinRM Started."
Write-Output "Stopping PowerShell transcript."
Stop-Transcript

Stop-Transcript