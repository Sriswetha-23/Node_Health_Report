#!/bin/bash

#configure for telegram update
BOT_TOKEN="7744603926:AAGGHhSnQecXwV1DVns51cayQ4yH5VbJfjk"
CHAT_ID="1185036453"

#Setting values for varaibles
#$( )--> command substitution: passing the o/p of the command as value for variable

HOSTNAME=$(hostname)
DATE=$(date)

#Calculate CPU usage
CPU_USAGE=$(grep 'cpu ' /proc/stat | awk '{printf "%.2f", (($2+$4)100/($2+$4+$5))}')

#Calculate memory usage
MEM_USAGE=$(free -m | grep Mem | awk '{print (($3/$2)100)}')

#Calculate disk usage
DISK_USAGE=$(df / | awk 'NR==2 {print int($5)}')

MESSAGE=" NODE HEALTH REPORT - $HOSTNAME
Date:$DATE

CPU Usage = ${CPU_USAGE}%
Memory Usage = ${MEM_USAGE}%
Disk Usage = ${DISK_USAGE}%
"

curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
	     -d chat_id="$CHAT_ID" \
	          -d text="$MESSAGE" \
		       -d parse_mode="Markdown" > /dev/null
