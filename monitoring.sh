#!/bin/bash

echo -n "#Architecture: "; uname -a

echo -n "#CPU physical : "; grep -c ^processor /proc/cpuinfo

echo -n "#vCPU : "; cat /proc/cpuinfo | grep processor | wc -l

echo -n "#Memory Usage: "; free -m | awk 'NR == 2{printf "%s/%sMB (%.2f%%)\n", $3, $2, ($3 / $2) * 100}'

echo -n "#Disk Usage: "; df -h | awk '$NF=="/"{printf "%d/%.1fGB (%s)\n", $3, $4, $5}'

echo -n "#CPU load: "; top -bn1 | grep 'load' | awk '{printf "%.2f%%\n", $(NF - 2)}'

echo -n "#Last boot: "; who | grep 'pts/0' | awk '{printf "%s %s\n", $3, $4}'

echo -n "#LVM use: "; if cat /etc/fstab | grep -q "/dev/mapper/"; then echo "yes"; else echo "no"; fi

echo -n "#Connexions TCP : "; cat /proc/net/tcp | wc -l | awk '{printf "%d", $1-1}'; echo " ESTABLISHED"

echo -n "#User log: "; w | wc -l | awk '{printf "%d\n", $1-2}'

echo -n "#Network: "; echo -n "IP "; ip route list | grep 'link' | awk '{printf "%s", $9}'
ip link show | grep 'link/ether' | awk '{printf " (%s)", $2}'; echo ""

echo -n "#Sudo : "; cat /var/log/sudo.log | grep 'COMMAND' | wc -l | tr '\n' ' '; echo "cmd"