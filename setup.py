import os
import subprocess
platform = os.name;

def term(cmd):
    p = subprocess.Popen(cmd,
                     shell=True,
                     stdout=subprocess.PIPE, 
                     stderr=subprocess.PIPE)
    out, err = p.communicate()
    return out

def display(message):
    match platform:
        case 'nt':
            term("Write-Host " + message)
        case 'posix':
            term("echo " + message)

if __name__ == "__main__":
    print("git4.me setup")
    match platform:
        case 'nt':
            script_path = "git4.me/setup.ps1"
            subprocess.run(["powershell.exe", "-ExecutionPolicy", "Bypass", "-File", script_path])
        case 'posix':
            display('MacOS')
            print(term("brew --version"))
