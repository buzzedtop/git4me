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
scoop install oraclejdk-lts@19
scoop install gh

code install extension Dart-Code.flutter

#Github Auth from token or initiate gh auth login
try {
    Get-Content -path 'G:\My Drive\ssh\mytoken.txt' | gh auth login --with-token 
} catch {
    gh auth login
}
