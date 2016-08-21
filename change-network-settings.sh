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

	echo -e $BLACK'--->Check Network Settings'
	echo 
	echo -e $RED'1. This script has been tested on Ubuntu (Server & Desktop).'
	echo -e '2. The author(s) cannot be held accountable for any problems that might occur if you run this script.'
	echo -e '3. Proceed only if you authorize this script to make changes to your system.'
	echo

	echo -e 'CONTINUE TO AGREE.  OTHERWISE PRESS    [ C T R L   +   C ]'$BLACK
	echo
}

########################### Prompt for the Interface to edit ###########################

echo -e $YELLOW'--->Getting ready to change Network Settings...'$BLACK
sudo nano /etc/network/interfaces

echo
echo -e $GREEN'--->All done. '$BLACK

echo 
echo -e $RED'A RESTART IS REQUIRED FOR THE CHANGES TO TAKE EFFECT!'$BLACK

echo

pause 'Press [Enter] to restart...'

sudo reboot now

exit 0