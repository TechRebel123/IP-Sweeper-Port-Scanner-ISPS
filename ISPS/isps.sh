#!/bin/bash
> ips.txt
> scan.txt
sudo apt update
sudo apt install figlet
clear
figlet -c PortScanner
echo "-------------------------------------"
echo "Created by TechRebel"
echo "                                     "
echo "Choose your option: "
echo "                                     "
echo "1. Only IPSweep of your network (Shows all online hosts on your network)"
echo "2. Both IPSweep and nmap port scanning for all the online hosts on your network (Will take longer)"
echo "                                     "
echo "-------------------------------------"
read option
if [[ "$option" == "1" ]] 
then	
	echo "Enter your ip: (Syntax: 192.168.237)"
	read inp_ip
	if [[ "$inp_ip" =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
    		for ip in `seq 1 254`; do
		ping -c 1 $inp_ip.$ip | grep "64 bytes" | cut -d " " -f 4 | tr -d ":" >> ips.txt &
		done
		wait
	else
    		echo "Invalid format! Please use the syntax: 192.168.237"
    		exit 1
	fi
	echo "All alive hosts: "
	echo "-------------------------------------"
	cat ips.txt
	echo "-------------------------------------"
	wait

elif [[ "$option" == "2" ]]; then
	echo "Enter your ip: (Syntax: 192.168.237)"
	read inp_ip
	echo "Enter your preferred nmap command: (Press enter for default) "
	read nmap_cmd
	if [[ "$inp_ip" =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
    		for ip in `seq 1 254`; do
		ping -c 1 $inp_ip.$ip | grep "64 bytes" | cut -d " " -f 4 | tr -d ":" >> ips.txt &
		done
		wait
	else
    		echo "Invalid format! Please use the syntax: 192.168.237"
    		exit 1
	fi
	echo "All alive hosts: "
	echo "-------------------------------------"
	cat ips.txt
	echo "-------------------------------------"
	wait
	
	echo "Scanning all ip's using nmap: (This may take longer)"
	if [ -z "$nmap_cmd" ]; then
		for i in $(cat ips.txt); do nmap $i >> scan.txt &
		done
		wait
		echo "Results: "
		echo "-------------------------------------"
		cat scan.txt
		echo "-------------------------------------"
	else
		for i in $(cat ips.txt); do $nmap_cmd $i >> scan.txt &
		done
		wait
		echo "Results: "
		echo "-------------------------------------"
		cat scan.txt
		echo "-------------------------------------"
	fi

else
	echo "Invalid Option!"
fi
