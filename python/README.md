# INSRALLACJA PYTHONA

### stwórz folder DIR_PYTHON
np
``` BASH
mkdir D:\praca\python\python-3.13.9
``` 

### pobrać pythona

wybrać -> https://www.python.org/downloads/windows/

wybrać -> https://www.python.org/ftp/python/3.13.9/python-3.13.9-embed-amd64.zip
pobrać i rozpakować w folderze DIR_PYTHON

![alt text](image.png)

### instalacja PIP 

https://bootstrap.pypa.io tu jest opis co i jak zrobić

pobranie pliku https://bootstrap.pypa.io/get-pip.py 
wejdź do przeglądarki i zapisz w folderze DIR_PYTHON get-pip.py 

``` BASH
cd D:\praca\python\python-3.13.9
python get-pip.py
``` 

### gdy wyskoczy błąd po wpisaniu pip.exe
![alt text](image-1.png)

w pliku sprawdzić  python313._pth czy jest 
należy dodać 

``` BASH
Lib\site-packages
``` 

![alt text](image-2.png)

