Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

iex (new-object net.webclient).downloadstring('https://get.scoop.sh')

scoop bucket add extras
scoop install extras/vscode
