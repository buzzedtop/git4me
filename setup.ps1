Write-Output("v1.0.17")
try {
    scoop update
}
catch {
    #iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
    irm get.scoop.sh | iex
}

if (Test-Path -Path 'G:\My Drive\ssh\') {
    Write-Host "Drive G is mounted."
} else {
    & 'C:\Program Files\Google\Drive File Stream\97.0.1.0\GoogleDriveFS.exe'
}

Write-Output("Git Install")
Start-Job -ScriptBlock { scoop install git } -name git
Get-Job | Wait-Job
Get-Job | Remove-Job

Write-Output("Bucket Updates")
Start-Job -ScriptBlock { scoop bucket add main } -name bucket_main
Start-Job -ScriptBlock { scoop bucket add extras } -name bucket_extras
Start-Job -ScriptBlock { scoop bucket add java } -name bucket_java
Get-Job | Wait-Job
Get-Job | Remove-Job

Write-Output("Github Gitlab CLI")
Start-Job -ScriptBlock { scoop install gh } -name gh
Start-Job -ScriptBlock { scoop install glab } -name gl
Get-Job | Wait-Job
Get-Job | Remove-Job

try {
    Get-Content -path 'G:\My Drive\ssh\mytoken.txt' | gh auth login --with-token 
} catch {
    gh auth login
}

Get-Job | Wait-Job
Get-Job | Remove-Job
scoop install 1password-cli
Invoke-Expression (Get-Content -path 'G:\My Drive\ssh\op.ps1' -Raw)

$userInput = Read-Host "curl ubuntu? y/n"
if ($userInput -eq "y") {
    curl http://releases.ubuntu.com/focal/ubuntu-20.04.6-desktop-amd64.iso -UseBasicParsing -b
} else {
    Write-Output "Curl Ubuntu Skipped"
}

$userInput = Read-Host "flutter setup? y/n"
if ($userInput -eq "y") {
    Write-Output("Flutter Setup Install")
    Start-Job -ScriptBlock { scoop install vscode } -name code
    Start-Job -ScriptBlock { scoop install flutter } -name flutter
    Start-Job -ScriptBlock { scoop install android-clt } -name aclt
    Start-Job -ScriptBlock { scoop install android-studio } -name astu
    Start-Job -ScriptBlock { scoop install oraclejdk-lts@19 } -name java
    Get-Job | Wait-Job
    Get-Job | Remove-Job
    Write-Output("Configuration Start")
    Start-Job -ScriptBlock { code install extension Dart-Code.flutter } -name ext_dart
} else {
    Write-Output "Flutter Setup Skipped"
}

$userInput = Read-Host "VM setup? y/n"
if ($userInput -eq "y") {
    Write-Output("qemu  Install")
    Write-Output("https://saisuman.org/blog/run-ubuntu-in-windows-using-qemu")
    Start-Job -ScriptBlock { scoop install qemu } -name qemu
    Get-Job | Wait-Job
    Get-Job | Remove-Job
} else {
    Write-Output "VM Setup Skipped"
}
