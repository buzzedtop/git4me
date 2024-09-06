Write-Output("v1.0.7")
Write-Output("echo Scoop Check")
try {
    scoop update
}
catch {
    #iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
    irm get.scoop.sh | iex
}

Write-Output("echo Git Install")

Start-Job -ScriptBlock { scoop install git } -name git

Get-Job | Wait-Job

Write-Output("echo Bucket Add")

Start-Job -ScriptBlock { scoop bucket add main }
Start-Job -ScriptBlock { scoop bucket add extras }
Start-Job -ScriptBlock { scoop bucket add java }

Get-Job | Wait-Job

Write-Output("echo Mass Install")

Start-Job -ScriptBlock { scoop install vscode } -name code
Start-Job -ScriptBlock { scoop install flutter } -name flutter
Start-Job -ScriptBlock { scoop install android-clt } -name aclt
Start-Job -ScriptBlock { scoop install android-studio } -name astu
Start-Job -ScriptBlock { scoop install oraclejdk-lts@19 } -name java
Start-Job -ScriptBlock { scoop install gh } -name gh
Start-Job -ScriptBlock { scoop install glab } -name gl

Get-Job | Wait-Job

Write-Output("echo Configurations")

Start-Job -ScriptBlock { code install extension Dart-Code.flutter }

Wait-Job -Name "gh" {
    #Github Auth from token or initiate gh auth login
    try {
        Get-Content -path 'G:\My Drive\ssh\mytoken.txt' | gh auth login --with-token 
    } catch {
        gh auth login
    }
}
