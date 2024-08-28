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

scoop install vscode
scoop install flutter
scoop install android-clt
scoop install android-studio
scoop install java/oraclejdk-lts
