PS


### sprawdzanie jaki proces nasłuchuje na jakim porcie

``` PowerShell 
Get-NetTCPConnection -LocalPort 9002
```


### sprawdzenie jakie ma połączenia proces

``` PowerShell 
Get-NetTcpConnection -OwningProcess 18948
```


### sprawdzenie jak jest 

``` PowerShell 
Test-NetConnection -ComputerName 127.0.0.1 -Port 9002
```

### pobranie adresu wsl
``` PowerShell 
$wsl_ip = (wsl hostname -I).trim()
Write-Host "WSL Machine IP: ""$wsl_ip"""
```

### tworzenie proxy
#### wyświetlenie procy proxy 
``` PowerShell 
netsh interface portproxy show all 
```