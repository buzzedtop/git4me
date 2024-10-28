Write-Output("v1.0.19")
try {
    scoop update
}
catch {
    #iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
    irm get.scoop.sh | iex
}

$default = 'G:\My Drive\'
if (!($path = Read-Host "Default path: [$default] (Press Enter), Input new Path")) { $path = $default }

if (Test-Path -Path $path) {
    Write-Host "$path is valid."
} else {
    if ([System.DirectoryServices.ActiveDirectory.Domain]::GetComputerDomain().Name -eq 'adws.udayton.edu' & 'C:\Program Files\Google\Drive File Stream\97.0.1.0\GoogleDriveFS.exe'0)) {
        }
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
    Get-Content -path (-join($default,'ssh\mytoken.txt')) | gh auth login --with-token 
} catch {
    gh auth login
}

Get-Job | Wait-Job
Get-Job | Remove-Job
scoop install 1password-cli
Invoke-Expression (Get-Content -path (-join($default,'ssh\op.ps1')) -Raw)

if (Test-Path -Path (-join($default,'git\ubuntu-20.04.6-desktop-amd64.iso')) {
    Write-Output "Ubuntu Iso 20.04 Exist"
} else {
    $userInput = Read-Host "curl ubuntu? y/n"
    if ($userInput -eq "y") {
        curl http://releases.ubuntu.com/focal/ubuntu-20.04.6-desktop-amd64.iso -UseBasicParsing -b
    } else {
        Write-Output "Curl Ubuntu Skipped"
    }
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
    cd 'G:\My Drive\git'
    if (Test-Path -Path (-join($default,'git\Ubuntu20.img'))) {
        qemu-system-x86_64 -m 1G -smp 2 -boot order=dc -hda .\Ubuntu20.img -cdrom .\ubuntu-20.04.6-desktop-amd64.iso
    else {
        qemu-img create -f qcow2 Ubuntu20.img 20G
        qemu-system-x86_64 -m 1G -smp 2 -boot order=dc -hda .\Ubuntu20.img -cdrom .\ubuntu-20.04.6-desktop-amd64.iso
    }
} else {
    Write-Output "VM Setup Skipped"
}
