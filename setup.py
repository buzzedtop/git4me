import os
print("Hello")
print(os.name)
platform = os.name;

match platform:
    case 'nt':
        print('nt')
