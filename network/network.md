

połączenie się do zasobu innego komputera
``` PowerShell 
net use \\{HOSTNAME}\d$ /USER:{HOSTNAME}\{LOGIN} {PASSWORD}
``` 
połączenie się do zasobu innego komputera
``` PowerShell 
Enter-PSSession -ComputerName {HOSTNAME} -Credential '{LOGIN}\{PASSWORD}' 
``` 


### sprawdzanie jaki proces nasłuchuje na jakim porcie [GET-NEtTCPConnection](https://docs.microsoft.com/en-us/powershell/module/nettcpip/get-nettcpconnection?view=winserver2012r2-ps&redirectedfrom=MSDN)

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

### tworzenie proxy [NETSH](https://docs.microsoft.com/en-us/windows-server/networking/technologies/netsh/netsh-contexts)

#### wyświetlenie procy proxy 
``` cmd 
netsh interface portproxy show all 
```
#### tworzenie reguły

``` PowerShell 
netsh interface portproxy add v4tov4 listenport=9002 listenaddress=0.0.0.0 connectport=9002 connectaddress=192.168.8.9
```
example przekierowanie adresu z wsl do localhost 9002

``` PowerShell 
$wsl_ip = (wsl hostname -I).trim()
Write-Host "WSL Machine IP: ""$wsl_ip"""
netsh interface portproxy add v4tov4 listenport=9002 listenaddress=0.0.0.0 connectport=9002 connectaddress=$wsl_ip
```

#### skasowanie reguł 
``` PowerShell 
netsh interface portproxy reset
```