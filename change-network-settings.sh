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
	echo -e "     ██╗██╗   ██╗██╗ ██████╗███████╗██████╗"
	echo -e "     ██║██║   ██║██║██╔════╝██╔════╝██╔══██╗"
	echo -e "     ██║██║   ██║██║██║     █████╗  ██████╔╝"
	echo -e "██   ██║██║   ██║██║██║     ██╔══╝  ██╔══██╗"
	echo -e "╚█████╔╝╚██████╔╝██║╚██████╗███████╗██║  ██║"
	echo -e " ╚════╝  ╚═════╝ ╚═╝ ╚═════╝╚══════╝╚═╝  ╚═╝"

	echo -e $CYAN
	echo -e "Brought to you by PREngineer"
	echo
	echo -e $GREEN'Change Network Settings'
	echo 

	agree
}

function agree()
{
	########################### Show AGREEMENT Information ###########################

	echo -e $RED'1. This script has been tested on Ubuntu (Server & Desktop).'
	echo -e '2. The author(s) cannot be held accountable for any problems that might occur if you run this script.'
	echo -e '3. Proceed only if you authorize this script to make changes to your system.'
	echo

	echo -e 'CONTINUE TO AGREE.  OTHERWISE PRESS    [ C T R L   +   C ]'$BLACK
	echo
}

########################### Show Menu Options ###########################
function options()
{
	title

	echo -e $YELLOW'@---@---@---@---@---@--- CHOOSE ---@---@---@---@---@---@'
	echo -e $YELLOW'01. '$BLACK'Add - NEW Wireless Configuraton'
	echo -e $YELLOW'02. '$BLACK'Add - NEW Ethernet Configuration'
	echo -e $YELLOW'03. '$BLACK'Edit - EXISTING Wireless Configuration'
	echo -e $YELLOW'04. '$BLACK'Edit - EXISTING Ethernet Configuration'
	echo -e $YELLOW'05. '$BLACK'Change - Primary DNS Servers Configuration'
	echo -e $YELLOW'@---@---@---@---@---@--------------@---@---@---@---@---@'
	echo -e $YELLOW'99. '$BLACK'View - Go back to Main Menu'
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

function write_config()
{
echo "# Network Configuration by Juicer for Orange Pi
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp
	address 10.0.0.9
	netmask 255.255.255.0
	network 10.0.0.0
	broadcast 10.0.0.255
	gateway 10.0.0.1
	dns-nameservers 8.8.8.8 8.8.4.4

auto wlan0
iface wlan0 inet static
	address 10.0.0.75
	netmask 255.255.255.0
	gateway 10.0.0.1
	dns-nameservers 8.8.8.8 8.8.4.4
	broadcast 10.0.0.255
	network 10.0.0.0
	wpa-ssid CruiseNetwork
	wpa-psk ushallnotpass" > /etc/network/interfaces
}

########################### Prompt for the Interface to edit ###########################

echo -e $YELLOW'--->Getting ready to change Network Settings...'$BLACK
sudo nano /etc/network/interfaces

echo
echo -e $GREEN'--->All done. '$BLACK



########################### Restarting Network Services ###########################

echo 
echo -e $YELLOW'--->Restarting Network Services...'$BLACK
sudo /etc/init.d/networking restart
echo
echo -e $GREEN'--->All done. '$BLACK

exit 0