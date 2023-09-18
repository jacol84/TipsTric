### aktualizacja w POWERSHELL wszystkich obrazów 
docker images --format "{{.Repository}}" | Where-Object {$_ -ne "<none>"} | %{docker pull $_}

### Obraz Oracle 19
docker run --name oracle19 -p 1524:1521 -p 5501:5500 -e ORACLE_SID=orcl -e ORACLE_PWD=manager -e TZ="Europe/Warsaw" -v S:/oracle/dmp:/u01/app/oracle/admin/orcl/dpdump --hostname db_zgora oracle/database:19.3.0-ee