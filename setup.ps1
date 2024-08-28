try {
    iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
}
catch {
    Write-Outpit "Scoop Altready installed"
}

scoop bucket add main
scoop bucket add extras
scoop install main/git-tfs
scoop install extras/vscode
