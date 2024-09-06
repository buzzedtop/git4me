#Accepts a Job as a parameter and writes the latest progress of it
function WriteJobProgress
{
    param($Job)

    #Make sure the first child job exists
    if($Job.ChildJobs[0].Progress -ne $null)
    {
        #Extracts the latest progress of the job and writes the progress
        $jobProgressHistory = $Job.ChildJobs[0].Progress;
        $latestProgress = $jobProgressHistory[$jobProgressHistory.Count - 1];
        $latestPercentComplete = $latestProgress | Select -expand PercentComplete;
        $latestActivity = $latestProgress | Select -expand Activity;
        $latestStatus = $latestProgress | Select -expand StatusDescription;
    
        #When adding multiple progress bars, a unique ID must be provided. Here I am providing the JobID as this
        Write-Progress -Id $Job.Id -Activity $latestActivity -Status $latestStatus -PercentComplete $latestPercentComplete;
    }
}

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

#Test Async Job 1. Iterates through 10 integers and sleeps 1 second in between
Start-Job –Scriptblock {scoop install vscode}
Start-Job –Scriptblock {scoop install flutter}
Start-Job –Scriptblock {scoop install android-clt}
Start-Job –Scriptblock {scoop install android-studio}
Start-Job –Scriptblock {scoop install oraclejdk-lts@19}
Start-Job –Scriptblock {scoop install gh}
Start-Job –Scriptblock {scoop install glab}
#Monitor all running jobs in the current sessions until they are complete
#Call our custom WriteJobProgress function for each job to show progress. Sleep 1 second and check again

#Start-Job -ScriptBlock { scoop install vscode } -name code
#Start-Job -ScriptBlock { scoop install flutter } -name flutter
#Start-Job -ScriptBlock { scoop install android-clt } -name aclt
#Start-Job -ScriptBlock { scoop install android-studio } -name astu
#Start-Job -ScriptBlock { scoop install oraclejdk-lts@19 } -name java
#Start-Job -ScriptBlock { scoop install gh } -name gh
#Start-Job -ScriptBlock { scoop install glab } -name gl

while((Get-Job | Where-Object {$_.State -ne "Completed"}).Count -gt 0)
{    
 
    Start-Sleep -Seconds 1
}

#Get-Job | Remove-Job #Unless you need the output of these script then use receive-job first

#write-host "Processed"

Start-Job -ScriptBlock { code install extension Dart-Code.flutter }

#Github Auth from token or initiate gh auth login
try {
    Get-Content -path 'G:\My Drive\ssh\mytoken.txt' | gh auth login --with-token 
} catch {
    gh auth login
}
