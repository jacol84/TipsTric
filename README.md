# Tips & Tric

## PowerShell i CMD i BASH

 ***
### clean history 
(win-PS) sksowanie 3, i 6 pozycji z get-history
``` PowerShell
Clear-History -Id 3, 5
```

(linux) sksowanie 6 pozycji z history
``` BASH
history -d 6
``` 

 ***
### tail
(win-PS)
``` PowerShell
Get-Content -Wait log.log -Tail 10 
```

(linux)
``` BASH
tail -f log.log
``` 

### after kill process show CommandLine
(win-PS)
``` PowerShell
Get-Process java |where CommandLine -Like '*8787*' | where CommandLine -Like '*wild*'| %{Write-Host $_.CommandLine +$_.Id + $_.Name ; $_} | Stop-Process -Confirm
```

***
###  aktualizacja bibliotek za pomoca apt
``` BASH
sudo apt-get update && sudo apt-get upgrade -y
```
***
### [WSL]

***
### [MD]
***
### [VIM]







[WSL]: /wsl/wsl.md
[MD]: /md/md.md
[VIM]: /vim/vim.md