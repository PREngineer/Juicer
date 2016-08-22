#!/bin/bash
# Script Name: Change Network Settings
# Author: PREngineer (Jorge Pabon) - pianistapr@hotmail.com
# Publisher: Jorge Pabon
# License: Personal Use (1 device)
###########################################################

# Color definition variables
YELLOW='\e[33;3m'
RED='\e[91m'
BLACK='\033[0m'
CYAN='\e[96m'
GREEN='\e[92m'

SCRIPTPATH=$(pwd)

function pause()
{
   read -p "$*"
}

function title()
{
	# Make sure to clear the Terminal
	clear

	# Display the Title Information
	echo 
	echo -e $RED
	echo -e "╔══════════════════════════════════════════════╗"
	echo -e "║      ██╗██╗   ██╗██╗ ██████╗███████╗██████╗  ║"
	echo -e "║      ██║██║   ██║██║██╔════╝██╔════╝██╔══██╗ ║"
	echo -e "║      ██║██║   ██║██║██║     █████╗  ██████╔╝ ║"
	echo -e "║ ██   ██║██║   ██║██║██║     ██╔══╝  ██╔══██╗ ║"
	echo -e "║ ╚█████╔╝╚██████╔╝██║╚██████╗███████╗██║  ██║ ║"
	echo -e "║  ╚════╝  ╚═════╝ ╚═╝ ╚═════╝╚══════╝╚═╝  ╚═╝ ║"
	echo -e "╚══════════════════════════════════════════════╝ for Orange Pis"
	echo -e $CYAN"          Brought to you by PREngineer"
	echo
	echo -e $GREEN'Change Network Settings Menu'$BLACK
	echo

	agree
}

function agree()
{
	########################### Show AGREEMENT Information ###########################

	echo -e "╔═════════════════════════════════════════════════════════════════════════════════════════════════════════╗"
	echo -e '║'$RED' 1. This tool has been tested on Ubuntu (Server & Desktop).'$BLACK'                                              ║'
	echo -e '║'$RED' 2. The author(s) cannot be held accountable for any problems that might occur if you run this tool.'$BLACK'     ║'
	echo -e '║'$RED' 3. Proceed only if you authorize this tool to make changes to your system.'$BLACK'                              ║'
	echo -e '║═════════════════════════════════════════════════════════════════════════════════════════════════════════║'
	echo -e '║'$RED'        CONTINUE TO AGREE.  OTHERWISE PRESS    [ C T R L   +   C ]'$BLACK'                                       ║'
	echo -e '╚═════════════════════════════════════════════════════════════════════════════════════════════════════════╝'
	echo
}

########################### Show Menu Options ###########################
function options()
{
	title

	echo -e $YELLOW'@---@---@---@---@---@--- CHOOSE ---@---@---@---@---@---@'
	echo -e $YELLOW'[01] '$BLACK'Add - NEW Wireless Configuraton [WPA2-Personal]'
	echo -e $YELLOW'[02] '$BLACK'Add - NEW Ethernet Configuration'
	echo -e $YELLOW'[03] '$BLACK'Edit - EXISTING Wireless Configuration'
	echo -e $YELLOW'[04] '$BLACK'Edit - EXISTING Ethernet Configuration'
	echo -e $YELLOW'[05] '$BLACK'Change - Primary DNS Servers Configuration'
	echo -e $YELLOW'@---@---@---@---@---@--------------@---@---@---@---@---@'
	echo -e $YELLOW'[99] '$BLACK'View - Go back to Main Menu'
	echo -e $YELLOW'@---@---@---@---@---@--------------@---@---@---@---@---@'
	echo
	echo -e 'Type your choice and press [ENTER]: '
	
	read option

	case $option in

		1 | 01)
	        add_wifi
	        ;;

	    2 | 02)
	        add_lan
	        ;;

	  	3 | 03)
	        edit_wifi
	        ;;

	   	4 | 04)
	        edit_lan
	        ;;

	    5 | 05)
	        change_dns
	        ;;

	    99 | 99)
			cd $SCRIPTPATH
			sudo ./juicer.sh
			exit 0
	        ;;

	    *)
	       	echo -e $RED'Invalid Option'$BLACK
			options
	esac
}

function add_wifi()
{
	display_wifi

	########################### Prompt for WLAN & MODE ###########################
	go=$true
	while [$go -eq $true];
	do
		echo
		echo -e $BLACK"Which Wireless Adapter do you want to configure? [wlanX] : "$CYAN
		read wlan

		case $wlan in

			'')
		        echo -e $RED"Please provide a value!"
				;;

		    *)
		       	echo -e $BLACK"Got it!  We will be modifying Interface '$wlan'."
		       	break
		esac
	done

	# Check that the changes can be applied
	erase=$false
	add=$false
	validate_wifi

	echo -e $BLACK"Do you want to set up a 'static' or 'dhcp' configuration : "$CYAN
	read mode

	########################### Prompt for IP Address ###########################
	title
	echo -e $YELLOW"--------------------------------------------------------"
	echo -e "An IP Address is the UNIQUE identifier of your device in"
	echo -e "your Network.  It usually is:"
	echo -e "                      192.168.0.x"
	echo -e "                           OR"
	echo -e "                      10.0.0.x"
	echo -e "--------------------------------------------------------"
	echo -e $RED"MAKE SURE TO USE AN IP THAT IS NOT ALREADY BEING USED!!"
	echo -e "      USUALLY, IT CANNOT END WITH '.0' or '.255'!!"$YELLOW
	echo -e "--------------------------------------------------------"
	echo -e "-- Checking your IP in WINDOWS --"
	echo -e "You can view your local range in a Windows PC by opening"
	echo -e "Command Prompt and typing : 'ipconfig /all'.  Your "
	echo -e "current Connection should be listed and you can view "
	echo -e "your Windows PC's adapter IP."
	echo -e "--------------------------------------------------------"
	echo -e "-- Checking your IP in LINUX/MAC OS X --"
	echo -e "You can view your local range in a Linux or Mac OS X PC"
	echo -e "by opening a Terminal and typing 'ifconfig'.  Your"
	echo -e "current Connection should be listed and you can view"
	echo -e "your Linux/Mac PC's adapter IP."
	echo -e "--------------------------------------------------------"
	echo
	echo -e $BLACK"Enter the desired IP Address : "$CYAN
	read address

	########################### Prompt for Network ###########################
	title
	echo -e $YELLOW"--------------------------------------------------------"
	echo -e "Your computer or device is connected to a specific network.  It"
	echo -e "usually is just like your IP but ends with '.0':"
	echo -e "                      192.168.0.0"
	echo -e "                           OR"
	echo -e "                      10.0.0.0"
	echo -e "--------------------------------------------------------"
	echo -e $RED"MAKE SURE TO PUT THE RIGHT NETWORK!!"$YELLOW
	echo -e "--------------------------------------------------------"
	echo -e "-- Checking your NETWORK in WINDOWS --"
	echo -e "You can view your local range in a Windows PC by opening"
	echo -e "Command Prompt and typing : 'ipconfig /all'.  Your "
	echo -e "current Connection should be listed and you can view "
	echo -e "your Windows PC's adapter IP."
	echo -e "--------------------------------------------------------"
	echo -e "-- Checking your NETWORK in LINUX/MAC OS X --"
	echo -e "You can view your local range in a Linux or Mac OS X PC"
	echo -e "by opening a Terminal and typing 'ifconfig'.  Your"
	echo -e "current Connection should be listed and you can view"
	echo -e "your Linux/Mac PC's adapter IP."
	echo -e "--------------------------------------------------------"
	echo
	echo -e $BLACK"Enter the Network Address : "$CYAN
	read network

	########################### Prompt for Broadcast ###########################
	title
	echo -e $YELLOW"--------------------------------------------------------"
	echo -e "Your network has a special IP that is used to establish"
	echo -e "connectivity with new devices.  It is usually like your"
	echo -e "IP but ends with '.255':"
	echo -e "                      192.168.0.255"
	echo -e "                           OR"
	echo -e "                      10.0.0.255"
	echo -e "--------------------------------------------------------"
	echo -e $RED"MAKE SURE TO PUT THE RIGHT BROADCAST ADDRESS!!"$YELLOW
	echo -e "--------------------------------------------------------"
	echo -e "-- Checking your BROADCAST in WINDOWS --"
	echo -e "You can view your local range in a Windows PC by opening"
	echo -e "Command Prompt and typing : 'ipconfig /all'.  Your "
	echo -e "current Connection should be listed and you can view "
	echo -e "your Network Broadcast IP."
	echo -e "--------------------------------------------------------"
	echo -e "-- Checking your BROADCAST in LINUX/MAC OS X --"
	echo -e "You can view your local range in a Linux or Mac OS X PC"
	echo -e "by opening a Terminal and typing 'ifconfig'.  Your"
	echo -e "current Connection should be listed and you can view"
	echo -e "your Network Broadcast IP."
	echo -e "--------------------------------------------------------"
	echo
	echo -e $BLACK"Enter the Broadcast IP Address : "$CYAN
	read broadcast

	########################### Prompt for Mask ###########################
	title
	echo -e $YELLOW"--------------------------------------------------------"
	echo -e "A Network Mask defines how many computers/devices are allowed"
	echo -e "within your Network.  It usually is:"
	echo -e "                      255.255.255.0"
	echo -e "which represents 254 computers/devices."
	echo -e "--------------------------------------------------------"
	echo -e $RED"MAKE SURE TO USE THE ONE SPECIFIED FOR YOUR NETWORK!"$YELLOW
	echo -e "--------------------------------------------------------"
	echo -e "-- Checking your MASK in WINDOWS --"
	echo -e "You can view your local MASK in a Windows PC by opening"
	echo -e "Command Prompt and typing : 'ipconfig /all'.  Your "
	echo -e "current Connection should be listed and you can view "
	echo -e "your Network's mask."
	echo -e "--------------------------------------------------------"
	echo -e "-- Checking your MASK in LINUX/MAC OS X --"
	echo -e "You can view your local MASK in a Linux or Mac OS X PC"
	echo -e "by opening a Terminal and typing 'ifconfig'.  Your"
	echo -e "current Connection should be listed and you can view"
	echo -e "your Network's mask."
	echo -e "--------------------------------------------------------"
	echo
	echo -e $BLACK"Enter the desired Network Mask : "$CYAN
	read netmask

	########################### Prompt for Gateway ###########################
	title
	echo -e $YELLOW"--------------------------------------------------------"
	echo -e "Your network has a device named Router/Gateway.  This"
	echo -e "device is in charge of transferring your data from/to"
	echo -e "the outside world (Internet).  It usually is like"
	echo -e "your IP Address but ends with '.1' like so:"
	echo -e "                      192.168.0.1"
	echo -e "                           OR"
	echo -e "                      10.0.0.1"
	echo -e "--------------------------------------------------------"
	echo -e $RED"MAKE SURE TO USE THE ONE SPECIFIED FOR YOUR NETWORK!"$YELLOW
	echo -e "--------------------------------------------------------"
	echo -e "-- Checking your MASK in WINDOWS --"
	echo -e "You can view your local MASK in a Windows PC by opening"
	echo -e "Command Prompt and typing : 'ipconfig /all'.  Your "
	echo -e "current Connection should be listed and you can view "
	echo -e "your Network's mask."
	echo -e "--------------------------------------------------------"
	echo -e "-- Checking your MASK in LINUX/MAC OS X --"
	echo -e "You can view your local MASK in a Linux or Mac OS X PC"
	echo -e "by opening a Terminal and typing 'ifconfig'.  Your"
	echo -e "current Connection should be listed and you can view"
	echo -e "your Network's mask."
	echo -e "--------------------------------------------------------"
	echo
	echo -e $BLACK"Enter the desired Gateway : "$CYAN
	read gateway

	########################### Prompt for DNS ###########################
	title
	echo -e $YELLOW"--------------------------------------------------------"
	echo -e "Your network doesn't know all of the internet.  It needs"
	echo -e "an outsider to tell it where to resolve a domain name"
	echo -e "like 'google.com' into an actual IP Address.  This is a"
	echo -e "DNS Server.  You can use multiple DNS Servers.  Just"
	echo -e "separate each one with a space.  You can use public DNS"
	echo -e "servers like Google or Open DNS, or your ISP's.  Like: "
	echo -e " Google:          '8.8.8.8 8.8.4.4'"
	echo -e " OpenDNS: '208.67.222.222 208.67.220.220'"
	echo -e " Mixed:  '208.67.222.222 8.8.8.8 8.8.4.4 208.67.220.220'"
	echo -e "--------------------------------------------------------"
	echo -e $RED"MAKE SURE TO USE VALID ADDRESSES!"$YELLOW
	echo -e "--------------------------------------------------------"
	echo -e "-- Figuring Out Your DNS --"
	echo -e "A quick google search will give you your ISP's DNS or"
	echo -e "you can just call them and ask for it."
	echo -e "The Samples for Google and OpenDNS are accurate as of"
	echo -e "the creation of this tool.  Aug/21/2016"
	echo -e "--------------------------------------------------------"
	echo
	echo -e $BLACK"Enter the desired DNS Servers : "$CYAN
	read dns

	########################### Prompt for Wifi & Password ###########################
	title
	echo -e $RED" ---------------------"
	echo -e "| Watch out for typos!|"
	echo -e " ---------------------"
	echo
	echo -e $BLACK"Enter the Wireless Network Name [ESSID] : "$CYAN
	read wifi
	echo
	echo -e $BLACK"Enter the Wireless Network Password [Passphrase] : "$CYAN
	read pass
	
	########################### Clear File ###########################
	if [$erase -eq $true]
	then 
		write_wifi_clear
	fi
	if [$add -eq $true]
	then 
		add_wifi_write
	fi
}

function validate_wifi()
{
	########################### Retrieved configured devices ###########################
	ifconfig -a | grep 'eth' | awk '{print $1}' > eth
	mapfile -t eths < eth

	ifconfig -a | grep 'wlan' | awk '{print $1}' > wlan
	mapfile -t wlans < wlan

	########################### Prompt for Clear of Config ###########################
	title 
	echo -e $BLACK"You have the following Interfaces/Adapters configured:"

	echo -e "--------------"
	echo -e "---Ethernet---"
	for((i=0; i < ${#eths[@]}; i++));
	do
	        echo -e "${eths[i]}"
	done
	echo -e "---Wireless---"
	for((i=0; i < ${#wlans[@]}; i++));
	do
	        echo -e "${wlans[i]}"
	done
	echo -e "--------------"
	echo
	echo -e $RED" ------------------------------------------------------------------------"
	echo -e "| Y O U   C A N N O T   A D D    A N   A L R E A D Y    E X I S T I N G  |"
	echo -e "| A D A P T E R   T O   T H E   C O N F I G U R A T I O N   F I L E      |"
	echo -e " ------------------------------------------------------------------------"
	echo -e $YELLOW"If you see the interface '$wlan' in the list, type 'y' and press [ENTER]. "
	echo -e $YELLOW"Otherwise, type 'n' and press [ENTER]: " $CYAN
	read cannotAdd

	case $cannotAdd in

		'y' | 'Y')
			clear_wifi
			;;

		'n' | 'N')
			echo -e $GREEN"OK, we are ready to add it to the configuration!  :)"
			add=$true
			;;

		*)
			echo -e $RED"YOU HAVE TO CONFIRM THAT THE INTERFACE IS NOT ALREADY CONFIGURED!"
			echo -e "Choice is not valid.  Type 'y' or 'n'."
			validate_wifi
			;;
	esac
}

function clear_wifi()
{
	go=$true
	while [$go -eq $true];
	do
		echo
		echo -e $RED"Cannot add the same adapter twice.  You can:"
		echo -e "[c] - Clear the Configuration file."
		echo -e "[e] - Edit the Configuration file."
		echo -e "[q] - Quit to Main Menu"
		echo -e $YELLOW"Type your choice and press [ENTER]: "$CYAN
		read choice

		case $choice in

			'c' | 'C')
				erase=$true
				echo
				echo -e $YELLOW"Clearing previous Configuration File..."
				break
				;;

			'e' | 'E')
				echo
				echo -e $YELLOW"Going back to Previous Menu, select Option [3]"
				options
				;;

			'q' | 'Q')
				echo
				echo -e $YELLOW"Going back to Main Menu"
				cd $SCRIPTPATH
				sudo ./juicer.sh
				;;

			'')
				echo -e $RED"You must provide a choice!"

			*)
				echo -e $RED"Choice is not valid.  Type one of the letter in brackets ( [] )"
				;;

		esac
	done
}

########################### Clear & Write File ###########################
function write_wifi_clear()
{
	echo "# Network Configuration by Juicer for Orange Pi\n" > interfaces
	echo "auto lo\n" >> interfaces
	echo "iface lo inet loopback\n" >> interfaces
	echo "\n" >> interfaces
	echo "auto eth0\n" >> interfaces
	echo "iface eth0 inet dhcp\n" >> interfaces
	echo "\n" >> interfaces
	echo "auto $wlan\n" >> interfaces
	echo "iface $wlan inet $mode\n" >> interfaces

	if [ "$mode" -eq "static" ]
	then 
		echo "	address $address\n" >> interfaces
		echo "	netmask $netmask\n" >> interfaces
		echo "	gateway $gateway\n" >> interfaces
		echo "	dns-nameservers $dns\n" >> interfaces
		echo "	broadcast $broadcast\n" >> interfaces
		echo "	network $network\n" >> interfaces
		echo "	wpa-ssid $wifi\n" >> interfaces
		echo "	wpa-psk $pass" >> interfaces
	fi

	sudo mv interfaces /etc/network/
}

########################### Add to File ###########################
function add_wifi_write()
{
	sudo cp /etc/network/interfaces interfaces

	echo "" >> interfaces
	echo "auto $wlan\n" >> interfaces
	echo "iface $wlan inet $mode\n" >> interfaces

	if [ "$mode" -eq "static" ]
	then 
		echo "	address $address\n" >> interfaces
		echo "	netmask $netmask\n" >> interfaces
		echo "	gateway $gateway\n" >> interfaces
		echo "	dns-nameservers $dns\n" >> interfaces
		echo "	broadcast $broadcast\n" >> interfaces
		echo "	network $network\n" >> interfaces
		echo "	wpa-ssid $wifi\n" >> interfaces
		echo "	wpa-psk $pass\n" >> interfaces
	fi

	sudo mv interfaces /etc/network/
}

########################### Show WiFi Adapters ###########################
function display_wifi()
{
	title

	echo 
	echo -e $YELLOW'--->Retrieving Available WiFi Adapter Details...'$BLACK
	echo 

	cat /etc/udev/rules.d/70-persistent-net.rules | grep '{address}' > test

	cat test | grep -o -P '(?<={address}==").*(?=", ATTR{dev_id})' > macs

	cat test | grep -o -P '(?<=NAME=").*(?=")' > names

	mapfile -t macs < macs

	mapfile -t names < names

	echo -e "---------------------------------"
	echo -e "Name \t MAC"
	echo -e "---------------------------------"

	for((i=0; i < ${#names[@]}; i++));
	do
	        echo -e "${names[i]} \t ${macs[i]}"
	done
	
	echo -e "---------------------------------"
	rm macs names test
}

function change_dns()
{
	########################### Prompt for IP Address ###########################
	title
	
	echo -e $BLACK"Enter the desired DNS Server : "$CYAN
	read dns
	echo "nameserver $dns" > resolv.conf

	go=$true
	while [$go -eq $true];
	do
		echo -e $BLACK"Add another DNS? [y/n] : "$CYAN
		read another

		case $another in

			'y' | 'Y')
		        echo -e $BLACK"Enter the desired DNS Server : "$CYAN
				read plus
				echo "nameserver $plus" >> resolv.conf
				;;

		    'n' | 'N')
		        echo -e $BLACK"Setting System's Primary DNS..."
		        break
		        ;;

		    *)
		       	echo -e $RED"Invalid Option.  Enter 'y' or 'n' and press [ENTER]: "$BLACK
		esac
	done

	sudo mv resolv.conf /etc/
}
########################### START EXECUTION ###########################

options


########################### Restarting Network Services ###########################

echo 
echo -e $YELLOW'--->Restarting Network Services...'$BLACK
sudo /etc/init.d/networking restart
echo
echo -e $GREEN'--->All done. '$BLACK

options
echo -e $GREEN"Changes were applied."

exit 0