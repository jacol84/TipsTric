### aktualizacja w POWERSHELL wszystkich obrazów 
docker images --format "{{.Repository}}" | Where-Object {$_ -ne "<none>"} | %{docker pull $_}