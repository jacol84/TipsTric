

### export putty (PS)
``` PowerShell
reg export HKCU\Software\SimonTatham ([Environment]::GetFolderPath("Desktop") + "\putty.reg")
```

### find wildfly and stop-process
``` PowerShell
Get-Process java |where CommandLine -Like '*8787*' | where CommandLine -Like '*wild*'| %{Write-Host $_.CommandLine +$_.Id + $_.Name ; $_} | Stop-Process -Confirm
```




### wsl ---- ????
``` PowerShell

$wsl_ip = (wsl hostname -I).trim()  `
Write-Host "WSL Machine IP: ""$wsl_ip""" `
Set-Clipboard -Value $wsl_ip `


$content = Get-Content D:\praca\nginx\nginx-1.22.0-local\conf\include\oms.conf  `
$content[4] = "        set `$www http://$wsl_ip;   # wsl"  `

Set-Content -Path D:\praca\nginx\nginx-1.22.0-local\conf\include\oms.conf 

```