Write-Output "---Running OOBE."
Start-Process -FilePath "C:\Windows\system32\sysprep\sysprep.exe" -ArgumentList "/quiet /generalize /oobe /shutdown"