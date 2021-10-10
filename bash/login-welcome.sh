#!/bin/bash
#
# This script produces a dynamic welcome message
# it should look like
#   Welcome to planet hostname, title name!

# Task 1: Use the variable $USER instead of the myname variable to get your name
# Task 2: Dynamically generate the value for your hostname variable using the hostname command - e.g. $(hostname)
# Task 3: Add the time and day of the week to the welcome message using the format shown below
#   Use a format like this:
#   It is weekday at HH:MM AM.
# Task 4: Set the title using the day of the week
#   e.g. On Monday it might be Optimist, Tuesday might be Realist, Wednesday might be Pessimist, etc.
#   You will need multiple tests to set a title
#   Invent your own titles, do not use the ones from this example

###############
# Variables   #
###############
title="Overlord"
USER="dennis"
echo "Enter the hostname "
read hostname
time=$(date "+%H:%M:%S")
day=$(date "+%A")
if [ $day="Monday"]; then
	title="Monday is a busy day"
elif [ $day="Tuesday"]; then
	title="Tuesday is a heavy day"
elif [ $day="Wednesday"]; then
	title="Wednesday is a lazy day"
elif [ $day="Thursday"]; then
	title="Thursay is a preparation day"
elif [ $day="Friday" ]; then
	title="Friday is a movie day"
elif [ $day="Saturday" ]; then
	title="Saturday is a holiday"
else
	title="Sunday is a family day"
fi
###############
# Main        #
###############
cat <<EOF

Welcome to planet $hostname, "$title $USER!"
Time and date is $time $day
EOF
