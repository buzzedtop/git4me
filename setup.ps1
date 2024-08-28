iex (new-object net.webclient).downloadstring('https://get.scoop.sh')

scoop bucket add main
scoop bucket add extras
scoop install main/git-tfs
scoop install extras/vscode
