***
### WSL 
#### run edge on wsl (not working for me :( )
* https://www.tenforums.com/tutorials/144208-windows-subsystem-linux-add-desktop-experience-ubuntu.html
 
* https://www.elevenforum.com/t/install-microsoft-edge-in-windows-11-wsl-ubuntu.385/

### zamkniecie
``` PowerShell
wsl --shutdown
```
### lsit z versia
``` PowerShell
wsl --list --verbose
```
lub
``` PowerShell
wsl -l -v
```
### uruchomienie konkretnej dystrybucji 
``` PowerShell
wsl -d docker-desktop
```

### run wsl sudo apt-get update
``` PowerShell
wsl sudo apt-get update
```


### dir i użycie grep pod windows
``` PowerShell
dir | wsl grep java 
```
