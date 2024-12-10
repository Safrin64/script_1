#!/bin/bash

# General Information
echo "===================="
echo "Server Status"
echo "===================="

# Total CPU usage
echo -e "\nTotal CPU usage:"
top -bn1 | grep "Cpu(s)" | awk '{print "Used: " $2 + $4 "%, Freeо: " 100 - $8 "%"}'

# Total Memory Usage
echo -e "\nTotal Memory Usage:"
free -m | awk 'NR==2{printf "Used: %s MB (%.2f%%), Free: %s MB\n", $3, $3*100/$2, $4}'

# Total Disk Usage
echo -e "\nTotal Disk Usage:"
df -h --total | grep 'total' | awk '{print "Used: " $3 " из " $2 " (" $5 " used)"}'

# Top 5 Processes by CPU Usage
echo -e "\nTop 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6 | awk '{if (NR==1) print; else printf "%-8s %-20s %s%%\n", $1, $2, $3}'

# Top 5 Processes by Memory Usage
echo -e "\nTop 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6 | awk '{if (NR==1) print; else printf "%-8s %-20s %s%%\n", $1, $2, $3}'

# Stretch goals (optional)
# OS version
echo -e "\nВерсия ОС:"
cat /etc/os-release | grep -w "PRETTY_NAME" | cut -d '"' -f2

# System Uptime
echo -e "\nSystem Uptime:"
uptime -p

# Load Average
echo -e "\nLoad Average:"
uptime | awk -F'load average:' '{print $2}'

# Logged-in Users
echo -e "\nLogged-in Users:"
who

# Failed Login Attempts
echo -e "\nFailed Login Attempts:"
grep "Failed password" /var/log/auth.log | wc -l 2>/dev/null || echo "Information unavailable"
