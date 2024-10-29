import os
import subprocess
print("Hello")
print(os.name)
platform = os.name;

match platform:
    case 'nt':
        print('nt')
        # Define the PowerShell command you want to execute
        command = "Get-ChildItem C:\\"
        # Run the PowerShell command and capture the output
        result = subprocess.run(["powershell", "-Command", command], capture_output=True, text=True)
        # Print the output
        print(result.stdout)

