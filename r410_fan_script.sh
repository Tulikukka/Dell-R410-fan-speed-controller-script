#!/bin/bash
#if you edit this with windows and save it, use console command: sed -i -e 's/\r$//' <file> to convert file to unix.
# ===========================================================================
#                            PROJECT DETAILS
# ===========================================================================
# LICENSE : GNU General Public License Version 2 (GPL)
# Author  : Markku Hyttinen | make90.hyttinen gmail.com | +358442885519
# Based on: Jamie's guide: https://blog.jamie.ie/loud-dell-r410-fans-and-how-to-fix-them/
# Company : TELOK ry
# Date    : Date 2019 09 24
# Project : R410 ipmitool fan adjuster
# Desc    : R410 doesn't have fan adjustment tool in BIOS, thus
#           you need to adjust speeds via idrac with ipmitool
#           this script has 3 different files!
# website : https://www.reddit.com/r/homelab/wiki/buildlogs/blfireflowerist01
# git     : 
# backups : 
# Language: Bash
# Style   : TUT Style++ (http://www.telok.fi/doku.php?projektit:tyyliopas_style_.pdf)
#
# Version : 5
# Changes : separated fan control enable to be in another script file. R410_fan_manual_enable.sh
#           
#
# HARDWARE DETAILS
# Chip type               : Dell PowerEdge R410 iDrac6 express or enterprise
# CPUs                    : 2x Intel L5640 (2x 60W)
# Program type            : Script / crontab
# Call frequency          : Every minute
#
# SOFTWARE DETAILS
# Operating system        : Unraid V6
# Plugins                 : Nerd Tools
#                              ->ipmitool-1.8.19a-x86_64-1.txz

# IPMI SETTINGS:
# Modify to suit your needs.
IPMIHOST=1.1.1.1
IPMIUSER=root
IPMIPW=yourpassword

#Oneline command to get uptimes to A, B & C. 
# Friend wrote this oneliner, need to write explanation what it does and why it does it.
read A B C <<<$(LC_ALL=C uptime | egrep -o 'average:.+' | cut -d : -f 2- | sed 's/,//g;')
#convert float numbers to integers by removing everything after . dot
A=${A%.*}
B=${B%.*}
C=${C%.*}

#The fanspeeds are adjussted to keep the last cpu ~65C @ 25C ambient.
# VERY LOW
if [[ $A -le 4 && $B -le 4 && $C -le 4 ]]
then
        echo 'cpu load very low'
		echo 'Setting fan speeds to 4.3k & 3.0k RPM'
		ipmitool -I lanplus -N 1 -R 1 -H $IPMIHOST -U $IPMIUSER -P $IPMIPW raw 0x30 0x30 0x02 0xff 0x18
# LOW
elif [[ $A -le 8 && $B -le 4 && $C -le 4 ]]
then
        echo 'cpu load low'
		echo 'Setting fan speeds to 5.3k & 3.4k RPM'
		ipmitool -I lanplus -N 1 -R 1 -H $IPMIHOST -U $IPMIUSER -P $IPMIPW raw 0x30 0x30 0x02 0xff 0x1d
# MODERATE
elif [[ $A -le 12 && $B -le 8 && $C -le 4 ]]
then
        echo 'cpu load moderate'
		echo 'Setting fan speeds to 5.6k & 3.8k RPM'
		ipmitool -I lanplus -N 1 -R 1 -H $IPMIHOST -U $IPMIUSER -P $IPMIPW raw 0x30 0x30 0x02 0xff 0x1f
#HIGH
elif [[ $A -le 16 && $B -le 12 && $C -le 8 ]]
then
        echo 'cpu load high'
		echo 'Setting fan speeds to 5.9k & 4.1k RPM'
		ipmitool -I lanplus -N 1 -R 1 -H $IPMIHOST -U $IPMIUSER -P $IPMIPW raw 0x30 0x30 0x02 0xff 0x20
#VERY HIGH
elif [[ $A -le 24 && $B -le 16 && $C -le 12 ]]
then 
        echo 'cpu load very high'
		echo 'Setting fan speeds to 6.2k & 4.3k RPM'
		ipmitool -I lanplus -N 1 -R 1 -H $IPMIHOST -U $IPMIUSER -P $IPMIPW raw 0x30 0x30 0x02 0xff 0x22
#BEYOND VERY HIGH
elif [[ $A -le 24 && $B -le 20 && $C -le 16 ]]
then
		echo 'cpu load beyond very high'
		echo 'Setting fan speeds to 6.6k & 4.6k RPM'
		ipmitool -I lanplus -N 1 -R 1 -H $IPMIHOST -U $IPMIUSER -P $IPMIPW raw 0x30 0x30 0x02 0xff 0x24
#ONE STEP FROM HELL
elif [[ $A -le 24 && $B -le 24 && $C -le 20 ]]
then
		echo 'cpu load one step from hell'
		echo 'Setting fan speeds to 7.5k & 5.0k RPM'
		ipmitool -I lanplus -N 1 -R 1 -H $IPMIHOST -U $IPMIUSER -P $IPMIPW raw 0x30 0x30 0x02 0xff 0x26
#MAX LOAD
else
		echo 'cpu load max reached, buckle up'
		echo 'Setting fan speeds to 8.0k & 5.5k RPM'
		ipmitool -I lanplus -N 1 -R 1 -H $IPMIHOST -U $IPMIUSER -P $IPMIPW raw 0x30 0x30 0x02 0xff 0x2b		
fi