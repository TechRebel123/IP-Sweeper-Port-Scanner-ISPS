#!/bin/python3

import sys
import socket
from datetime import datetime

if len(sys.argv) == 2:
    target = socket.gethostbyname(sys.argv[1])
else:
    print("Invalid hostname!")
    print("Syntax: python3 portscanner.py <ip>")
    sys.exit()

print("What type of scan do you want to perform?: ")
print("1. All ports")
print("2. Most common ports only")
option = input("Enter your option: ")
print("*" * 50)
print("Made by TechRebel")
print("Scanning target: " + target)
print("Started on: ", datetime.now())
print("*" * 50)
print('\n')

common_ports = [20, 21, 22, 23, 25, 53, 80, 110, 111, 135, 139, 143, 389, 443, 445, 465, 587, 636, 993, 995, 1433, 1521, 1723, 3306, 3389, 5432, 5900, 6379, 8000, 8080, 8443, 9200, 27017]

socket.setdefaulttimeout(1)

if option == "1":
    print("This will take time.")
    try:
        for port in range(1, 65535):
            s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            result = s.connect_ex((target, port))
            if result == 0:
                print(f"Port {port} is open")
            s.close()
    except KeyboardInterrupt:
        print("Exiting program.")
    except socket.gaierror:
        print("Hostname could not be resolved")
        sys.exit()
    except socket.error:
        print("Could not connect to server")
        sys.exit()
elif option == "2":
    print("Trying common ports:")
    try:
        for port in common_ports:
            s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            result = s.connect_ex((target, port))
            if result == 0:
                print(f"Port {port} is open")
            s.close()
    except KeyboardInterrupt:
            print("Exiting program.")
    except socket.gaierror:
            print("Hostname could not be resolved")
            sys.exit()
    except socket.error:
            print("Could not connect to server")
            sys.exit()
else:
     print("Invalid option!")
     sys.exit()
