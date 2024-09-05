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

Start-Job -ScriptBlock { scoop install vscode } -name code
Start-Job -ScriptBlock { scoop install flutter } -name flutter
Start-Job -ScriptBlock { scoop install android-clt } -name aclt
Start-Job -ScriptBlock { scoop install android-studio } -name astu
Start-Job -ScriptBlock { scoop install oraclejdk-lts@19 } -name java
Start-Job -ScriptBlock { scoop install gh } -name gh
Start-Job -ScriptBlock { scoop install glab } -name gl

$jobStatus = Get-Job
While ($jobStatus.State -ne "Completed"){
     $jobStatus = Get-Job
     Write-Progress -Activity "Waiting for jobs..." -PercentComplete $x
     If($x -eq 100){
          $x = 1
     }
    Else{
         $x += 1
    }

#Outside the while loop add the following to remove the progress bar when done
Write-Progress -Activity "Collecting Files..." -Completed
}

Get-Job | Remove-Job #Unless you need the output of these script then use receive-job first

Start-Job -ScriptBlock { code install extension Dart-Code.flutter }

#Github Auth from token or initiate gh auth login
try {
    Get-Content -path 'G:\My Drive\ssh\mytoken.txt' | gh auth login --with-token 
} catch {
    gh auth login
}
