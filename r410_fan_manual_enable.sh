#!/bin/bash
#if you edit this with windows and save it, use console command: sed -i -e 's/\r$//' <file> to convert file to unix.
# ===========================================================================
#                            PROJECT DETAILS
# ===========================================================================
# LICENSE : GNU General Public License Version 2 (GPL)
# Author  : Markku Hyttinen | make90.hyttinen gmail.com | +358442885519
# Based on: Jamie's guide & work: https://blog.jamie.ie/loud-dell-r410-fans-and-how-to-fix-them/
# Company : TELOK ry
# Date    : Date 2019 09 24
# Project : R410 ipmitool fan adjuster
# Desc    : R410 doesn't have fan adjustment tool in BIOS, thus
#           you need to adjust speeds via idrac with ipmitool
#           this script has 3 different files!
# website : https://www.reddit.com/r/homelab/wiki/buildlogs/blfireflowerist01
# git     : https://github.com/Tulikukka/Dell-R410-fan-speed-controller-script
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

# Force fan controls to be manual, NOTE!: resets only after complete power down!
ipmitool -I lanplus -N 1 -R 1 -H $IPMIHOST -U $IPMIUSER -P $IPMIPW raw 0x30 0x30 0x01 0x00
