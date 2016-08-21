#!/bin/bash
# Script Name: JUICER for Orange Pi
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

# Make sure all Scripts in this folder are executable
sudo chmod -R 775 * >/dev/null 2>&1

function pause()
{
   read -p "$*"
}

if [ "$EUID" -ne 0 ]
  then 
  echo
  echo -e $RED'Please run as root using the command: '$BLACK'sudo ./setup.sh'
  echo
  exit 0
fi

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
                                            
"

echo -e $CYAN
echo -e "Brought to you by PREngineer"
echo
echo -e $GREEN'JUICER for Orange Pi'$BLACK
echo 

echo -e $RED'1. This script has been tested on Ubuntu (Server & Desktop).'
echo -e '2. The author(s) cannot be held accountable for any problems that might occur if you run this script.'
echo -e '3. Proceed only if you authorize this script to make changes to your system.'$BLACK
echo

echo -e $YELLOW'@---@---@---@---@---@--- ADMIN ---@---@---@---@---@---@'
echo -e $YELLOW'00. '$BLACK'Update Auto-HTPC'
echo -e $YELLOW'@---@---@---@---@---@--- NETWORK ---@---@---@---@---@---@'
echo -e $YELLOW'01. '$BLACK'Check Network Settings'
echo -e $YELLOW'02. '$BLACK'Change Network Settings'
echo -e $YELLOW'99. '$BLACK'Exit'

echo
echo -n "Choose your action [00-99]: "
read option

case $option in

	0 | 00)
		echo
	        	echo -e $YELLOW'--->Checking for updates...'$BLACK
		git pull
		echo
		pause 'Press [Enter] to restart and continue...'
		cd $SCRIPTPATH
		sudo ./setup.sh
		exit 0
		;;

	1 | 01)
        sudo ./check-network-settings.sh
        ;;

    2 | 02)
        sudo ./change-network-settings.sh
        ;;

    *)
       	echo -e $RED'Invalid Option'$BLACK
		ScriptLoc=$(readlink -f "$0")
		sleep 1
		exec $ScriptLoc
esac
