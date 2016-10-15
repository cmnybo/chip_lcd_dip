#!/bin/bash

# This script is used for controlling the LCD backlight.
# It can increase, decrease, and set the backlight level.
# it can also turn the entire display on or off
# This script can be added to some key bindings for easy use

# path to backlight directory
backlight=/sys/class/backlight/backlight

# show help then exit
function usage() {
	echo "Usage: bl [option]"
	echo "--up      Increase Brightness By 10%"
	echo "--dn      Decrease Brightness By 10%"
	echo "--on      Turn LCD On"
	echo "--off     Turn LCD Off"
	echo "--get     Returns Current Brightness"
	echo "--toggle  Toggle Bacaklight On or Off"
	echo "(1-10)    Set Brightness to 10% - 100%"
	exit 0
}

# show help if no arguments are given
if [ -z $1 ]; then
	usage
fi

# get current brightness
brightness=$(cat $backlight/brightness) 

# parse arguments
case $1 in
	--up   )
		# increase brightness
		if [ $brightness -lt 10 ]; then
			echo $(($brightness + 1)) > $backlight/brightness
		fi
		exit 0;;
	--dn   )
		# decrease brightness
		if [ $brightness -gt 1 ]; then
			echo $(($brightness - 1)) > $backlight/brightness
		fi
		exit 0;;
	--on   )
		# turn displau on
		echo 0 > $backlight/bl_power
		exit 0;;
	--off  )
		# turn display off
		echo 1 > $backlight/bl_power
		exit 0;;
	--get  )
		# get current brightness
		echo "Brightness: $(($brightness * 10))%" 
		exit 0;;
	--toggle )
		pwr=$(cat $backlight/bl_power)
		if [ $pwr == 0 ]; then
			echo 1 > $backlight/bl_power
		else
			echo 0 > $backlight/bl_power
		fi
		exit 0;;
	-h | --help)
		# show help
		usage;;
	*      )
		# check for a number between 1 & 10
		for i in {1..10}; do
			if [ $1 == $i ]; then
				# set brightness and exit
				echo $i > $backlight/brightness
				exit 0
			fi
		done
		# if invalid argument was given, show error and exit
		echo "Invalid argument: $1"
		exit 1
esac
