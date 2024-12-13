
$path = "$env:HOMEDRIVE$env:HOMEPATH\.ivy2\cache\pl.mikronika.oms"
if (Test-Path $path) {
    Remove-Item -Path $path -Recurse -Force -confirm:$false -Verbose
} else {
    Write-Warning "Directory '$path' not found."
}


