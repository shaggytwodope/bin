#!/bin/dash

NAME="tuxalarm.sh"
AUTHOR="Craciun Dan"
HTTP="http://www.tuxarena.com/intro/tuxalarm.php"
MAIL="floydian.embryo@yahoo.com"
VERSION="0.2.0"
DATE="Feb 15, 2014"
LICENSE="GPLv2"

# TODO: make a cli music player using gstreamer and use that instead of avplay

alarm1="Replace this with the absolute path to an audio file (e.g. $HOME/Music/alarm.mp3)."
alarm2="Replace this with the absolute path to an audio file (e.g. $HOME/Music/alarm.mp3)."
alarm3="Replace this with the absolute path to a directory containing audio files."
interval="5"

bin_ogg123=0
bin_avplay=0

if [ -x /usr/bin/ogg123 ]; then
	#bin_ogg123=1
	bin_ogg123=0 # set this to 1 to use ogg123 instead of avplay
	# or replace all ogg123 occurences with mpg123; ogg123 plays only ogg and flac files
fi
if [ -x /usr/bin/avplay ]; then
	bin_avplay=1
fi

if [ $bin_ogg123 -eq 0 ] && [ $bin_avplay -eq 0 ]; then
	echo "WARNING: No suitable player found. The alarm will NOT work! (Tip: install vorbis-tools or avplay)"
	echo "Exiting..."
	exit 0
fi

echo -n "Enter alarm time as HHMM format (e.g. 0620 for 6:20 AM): "
read alarm

echo "Available alarms:"
echo "1. $alarm1"
echo "2. $alarm2"
echo "3. All files inside $alarm3"

valid=0
while [ $valid -eq 0 ]; do
	echo -n "Choose alarm file (default 1): "
	read input
	if [ "$input" = "1" ] || [ "$input" = "" ]; then
		valid=1
		default=1
	elif [ "$input" = "2" ]; then
		valid=1
		default=2
	elif [ "$input" = "3" ]; then
		found=0
		for i in $alarm3/*.ogg; do
			if [ -f $i ]; then
				found=1
			fi
		done
		for i in $alarm3/*.mp3; do
			if [ -f $i ]; then
				found=1
			fi
		done
		if [ $found -eq 1 ]; then
			valid=1
			default=3
		else
			echo "No .ogg or .mp3 files found inside $alarm3! Change the directory or the alarm will NOT work!"
			echo "Exiting..."
			exit 0
		fi
	fi
done

printalarm () {
	if [ $bin_ogg123 -eq 1 ]; then
		if [ $default -eq 1 ]; then
			echo ogg123 $alarm1
		elif [ $default -eq 2 ]; then
			echo ogg123 $alarm2
		else
			echo ogg123 $alarm3/*
		fi
	elif [ $bin_avplay -eq 1 ]; then
		if [ $default -eq 1 ]; then
			echo avplay -nodisp -autoexit $alarm1
		elif [ $default -eq 2 ]; then
			echo avplay -nodisp -autoexit $alarm2
		else
			echo avplay -nodisp -autoexit $alarm3'/*'
		fi
	fi
}

echo ""
echo "Alarm time: $alarm"
echo "Repeat interval: $interval"
echo -n "Command: "
printalarm
echo ""

playalarm () {
	if [ $bin_ogg123 -eq 1 ]; then
		if [ $default -eq 1 ]; then
			ogg123 $alarm1
		elif [ $default -eq 2 ]; then
			ogg123 $alarm2
		else
			ogg123 $alarm3/*.ogg
		fi
	elif [ $bin_avplay -eq 1 ]; then
		if [ $default -eq 1 ]; then
			avplay -nodisp -autoexit $alarm1
		elif [ $default -eq 2 ]; then
			avplay -nodisp -autoexit $alarm2
		else
			for i in $alarm3/*; do
				avplay -nodisp -autoexit $i
			done
		fi
	fi
	sleep $interval
}

passed=0
while [ $passed -eq 0 ]; do
	if [ `date +"%H%M"` = "$alarm" ]; then
		passed=1
		echo "Rise and shine! It is `date +"%A %b %d, %Y %H:%M"`. (Press ^C to stop the alarm)\n"
		
		while [ 1 ]; do
			playalarm
		done
	fi
	sleep 10
done

# ChangeLog
# v0.2.0 (Feb 15, 2014) - initial release
