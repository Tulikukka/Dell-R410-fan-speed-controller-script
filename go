#!/bin/bash
# This file is automatically converted to be unix compatible when unRAID starts!
# This file should be on /boot/config/ folder!
# Start the Management Utility
/usr/local/sbin/emhttp &
#First we enable our fans to be manually adjusted, change path to your liking
bash /boot/config/scripts/fans/r410_fan_manual_enable.sh
#Then we load existing crontab, pass it to cat and echo our every minute fan
#update script and write changes to crontab, which has been loaded to RAM.
crontab -l | { cat; echo "* * * * * bash /boot/config/scripts/fans/r410_fan_script.sh 1> /dev/null"; } | crontab -
