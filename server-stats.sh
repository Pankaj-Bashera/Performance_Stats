#!/bin/bash

echo "================ SERVER PERFORMANCE STATS ================"
echo

# ---------------- CPU Usage ----------------
echo "CPU Usage:"
top -bn1 | grep "Cpu(s)" | awk '{print "Used: " 100 - $8 "%"}'
echo

# ---------------- Memory Usage ----------------
echo "Memory Usage:"
free -m | awk 'NR==2{
    total=$2; used=$3; free=$4;
    printf "Total: %d MB\nUsed: %d MB (%.2f%%)\nFree: %d MB (%.2f%%)\n",
    total, used, used*100/total, free, free*100/total
}'
echo

# ---------------- Disk Usage ----------------
echo "Disk Usage:"
df -h / | awk 'NR==2{
    printf "Total: %s\nUsed: %s (%s)\nFree: %s (%s)\n",
    $2, $3, $5, $4, 100-$5
}'
echo

# ---------------- Top 5 CPU Processes ----------------
echo "Top 5 Processes by CPU Usage:"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
echo

# ---------------- Top 5 Memory Processes ----------------
echo "Top 5 Processes by Memory Usage:"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6
echo

# OS Version
echo "OS Version:"
grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"'
echo

# Uptime
echo "Uptime:"
uptime -p
echo

echo "========================================================="