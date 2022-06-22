PS


sprawdzanie jaki proces nasłuchuje na jakim porcie

``` PowerShell 
Get-NetTCPConnection -LocalPort 9002
```


sprawdzenie jakie ma połączenia proces

``` PowerShell 
Get-NetTcpConnection -OwningProcess 18948
```


sprawdzenie jak jest 

``` PowerShell 
Test-NetConnection -ComputerName 127.0.0.1 -Port 9002
```

