import os
import subprocess
platform = os.name;

def ps(cmd):
    print(cmd)
    completed = subprocess.run(["powershell", "-Command", cmd], capture_output=True)
    return completed

def term(cmd):
    print(cmd)
    p = subprocess.Popen('cmd',
                     shell=True,
                     stdout=subprocess.PIPE, 
                     stderr=subprocess.PIPE)
    out, err = p.communicate()
    return out

def display(message):
    match platform:
        case 'nt':
            ps("Write-Host " + message)
        case 'posix':
            term("echo " + message)

if __name__ == "__main__":
    print("Hello")
    match platform:
        case 'nt':
            display('Windows')
        case 'posix':
            display('MacOS')
            print(term("ls"))