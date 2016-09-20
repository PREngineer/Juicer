#!/bin/bash
# Script Name: 
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
	echo -e $GREEN'Manage Devices'$BLACK
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
	echo -e $YELLOW'[01] '$BLACK"Show My Drives"
	echo -e $YELLOW'[02] '$BLACK"Fix USB Drive Permissions 		[If you can't write]"
	echo -e $YELLOW'[03] '$BLACK"Safely Remove/Eject USB Drive	[Don't just pull]"
	echo -e $YELLOW'[04] '$BLACK''
	echo -e $YELLOW'[05] '$BLACK''
	echo -e $YELLOW'@---@---@---@---@---@--------------@---@---@---@---@---@'
	echo -e $YELLOW'[99] '$BLACK'Exit - Go back to Main Menu'
	echo -e $YELLOW'@---@---@---@---@---@--------------@---@---@---@---@---@'
	echo
	echo -e 'Type your choice and press [ENTER]: '
	
	read option

	case $option in

		1 | 01)
	        show_drives
	        ;;

	    2 | 02)
	        fix_permissions
	        ;;

	  	3 | 03)
	        eject_drive
	        ;;

	  	4 | 04)
	        
	        ;;

	   	5 | 05)
	        
	        ;;

	    6 | 06)
	        
	        ;;

	    99 | 99)
			cd $SCRIPTPATH
			sudo ./juicer.sh
			exit 0
	        ;;

	    *)
	       	echo -e $RED'Invalid Option!  Try again...'$BLACK
			options
	esac
}

###########################  ###########################
function show_drives()
{
	df -h | grep '/dev/' > drives

	mapfile -t temp < drives

	rm drives

	echo -e $YELLOW'Drive\tSpace\tUsed\tAvailable\tMounted\tType'
	echo -e '-----------------------------------------------'
	for((i=0; i < ${#drives[@]}; i++));
	do
		output=()
		output+=(echo $temp[i] | awk '{print $1}')
		output+=(echo $temp[i] | awk '{print $2}')
		output+=(echo $temp[i] | awk '{print $3}')
		output+=(echo $temp[i] | awk '{print $4}')
		output+=(echo $temp[i] | awk '{print $5}')
		output+=(echo $temp[i] | awk '{print $6}')
	    echo -e "${output[1]}\t${output[2]\t${output[3]\t${output[4]\t${output[5]\t${output[6]}"
	done
	echo -e '-----------------------------------------------'
}

###########################  ###########################
function fix_permissions()
{
	
}

###########################  ###########################
function eject_drive()
{
	
}

###########################  ###########################
function ()
{
	
}

########################### Start Execution ###########################
options