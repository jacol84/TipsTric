# TipsTric

## PowerShell i CMD i BASH

***
### tail
 (win-PS)

    Get-Content -Wait log.log -Tail 10 

(linux)

    tail -f log.log

***
###  aktualizacja bibliotek za pomoca apt
    sudo apt-get update && sudo apt-get upgrade -y

***
### WSL 
#### run edge on wsl
* https://www.tenforums.com/tutorials/144208-windows-subsystem-linux-add-desktop-experience-ubuntu.html
 
* https://www.elevenforum.com/t/install-microsoft-edge-in-windows-11-wsl-ubuntu.385/

### zamkniecie
    wsl --shutdown

### lsit z versia
    wsl --list --verbose
    //or
    wsl -l -v

