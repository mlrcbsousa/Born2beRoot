#!/bin/bash

architecture=$(uname -a)

physical_cpu=$(grep "physical id" /proc/cpuinfo | sort | uniq | wc -l)

virtual_cpu=$(grep -c ^processor /proc/cpuinfo)

memory_usage=$(free -m | awk 'NR==2{printf "%s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }')

total_disk=$(df -Bg | grep '^/dev/' | grep -v '/boot$' | awk '{ft += $2} END {print ft}')

used_disk=$(df -Bm | grep '^/dev/' | grep -v '/boot$' | awk '{ut += $3} END {print ut}')

percent_used_disk=$(df -Bm | grep '^/dev/' | grep -v '/boot$' | awk '{ut += $3} {ft+= $2} END {printf("%d"), ut/ft*100}')

cpu_load=$(top -bn1 | grep load | awk '{printf "%.2f%%\n", $(NF-2)}')

last_boot=$(who -b | awk '$1 == "system" {print $3 " " $4}')

lvm_partitions=$(lsblk | grep -c "lvm")

lvm_is_used=$(if [ $lvm_partitions -eq 0 ]; then echo no; else echo yes; fi)

# [$ sudo apt install net-tools]
tcp_connections=$(cat /proc/net/sockstat{,6} | awk '$1 == "TCP:" {print $3}')

users_logged_in=$(w -h | wc -l)

ipv4_address=$(hostname -I)

mac_address=$(ip link show | awk '$1 == "link/ether" {print $2}')

# sudo
sudo_commands_count=$(journalctl _COMM=sudo | grep -c COMMAND) 


wall "  
	#Architecture: $architecture
	#CPU physical: $physical_cpu
	#vCPU: $virtual_cpu
	#Memory Usage: $memory_usage
	#Disk Usage: $used_disk/${total_disk}Gb ($percent_used_disk%)
	#CPU load: $cpu_load
	#Last boot: $last_boot
	#LVM use: $lvm_is_used
	#Connexions TCP: $tcp_connections ESTABLISHED
	#User log: $users_logged_in
	#Network: IP $ipv4_address($mac_address)
	#Sudo: $sudo_commands_count cmd"