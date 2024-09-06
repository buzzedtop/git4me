Write-Output("v1.0.6")

try {
    scoop update
}
catch {
    #iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
    irm get.scoop.sh | iex
}

Start-Job -ScriptBlock { scoop install git } -name git

Get-Job | Wait-Job

Start-Job -ScriptBlock { scoop bucket add main }
Start-Job -ScriptBlock { scoop bucket add extras }
Start-Job -ScriptBlock { scoop bucket add java }

Get-Job | Wait-Job

Start-Job -ScriptBlock { scoop install vscode } -name code
Start-Job -ScriptBlock { scoop install flutter } -name flutter
Start-Job -ScriptBlock { scoop install android-clt } -name aclt
Start-Job -ScriptBlock { scoop install android-studio } -name astu
Start-Job -ScriptBlock { scoop install oraclejdk-lts@19 } -name java
Start-Job -ScriptBlock { scoop install gh } -name gh
Start-Job -ScriptBlock { scoop install glab } -name gl

Get-Job | Wait-Job

Start-Job -ScriptBlock { code install extension Dart-Code.flutter }

Wait-Job -Name "gh" {
    #Github Auth from token or initiate gh auth login
    try {
        Get-Content -path 'G:\My Drive\ssh\mytoken.txt' | gh auth login --with-token 
    } catch {
        gh auth login
    }
}