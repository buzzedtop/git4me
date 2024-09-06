Write-Output("v1.0.5")

try {
    scoop update
}
catch {
    iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
}

scoop install git

scoop bucket add main
scoop bucket add extras
scoop bucket add java

Start-ThreadJob -ScriptBlock { scoop install vscode } -name code
Start-ThreadJob -ScriptBlock { scoop install flutter } -name flutter
Start-ThreadJob -ScriptBlock { scoop install android-clt } -name aclt
Start-ThreadJob -ScriptBlock { scoop install android-studio } -name astu
Start-ThreadJob -ScriptBlock { scoop install oraclejdk-lts@19 } -name java
Start-ThreadJob -ScriptBlock { scoop install gh } -name gh
Start-ThreadJob -ScriptBlock { scoop install glab } -name gl

Get-Job | Wait-Job
Start-ThreadJob -ScriptBlock { code install extension Dart-Code.flutter }

Wait-Job -Name "gh" {
    #Github Auth from token or initiate gh auth login
    try {
        Get-Content -path 'G:\My Drive\ssh\mytoken.txt' | gh auth login --with-token 
    } catch {
        gh auth login
    }
}