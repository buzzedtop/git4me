try {
    scoop update
}
catch {
    iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
}

scoop bucket add main
scoop bucket add extras
scoop install git
scoop install vscode
scoop install flutter
scoop install android-clt
scoop install android-studio
scoop install java/oraclejdk-lts
