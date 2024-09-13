Write-Output("v1.0.15")
try {
    scoop update
}
catch {
    #iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
    irm get.scoop.sh | iex
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

Write-Output("Mass Install")
Start-Job -ScriptBlock { scoop install vscode } -name code
Start-Job -ScriptBlock { scoop install flutter } -name flutter
Start-Job -ScriptBlock { scoop install android-clt } -name aclt
Start-Job -ScriptBlock { scoop install android-studio } -name astu
Start-Job -ScriptBlock { scoop install oraclejdk-lts@19 } -name java
Start-Job -ScriptBlock { scoop install gh } -name gh
Start-Job -ScriptBlock { scoop install glab } -name gl
Get-Job | Wait-Job
Get-Job | Remove-Job

Write-Output("Configuration Start")
Start-Job -ScriptBlock { code install extension Dart-Code.flutter } -name ext_dart

try {
    Get-Content -path 'G:\My Drive\ssh\mytoken.txt' | gh auth login --with-token 
} catch {
    gh auth login
}

Get-Job | Wait-Job
Get-Job | Remove-Job
scoop install 1password-cli
Invoke-Expression (Get-Content -path 'G:\My Drive\ssh\op.ps1' -Raw)
