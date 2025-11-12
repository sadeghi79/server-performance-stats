#!/bin/bash

echo "========================================"
echo "      🖥️  Server Performance Stats"
echo "========================================"
echo ""

# --- CPU Usage ---
echo "🔹 Total CPU Usage:"
top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8"% used"}'
echo ""

# --- Memory Usage ---
echo "🔹 Memory Usage:"
free -h | awk '/Mem:/ {printf "Used: %s / Total: %s (%.2f%%)\n", $3, $2, $3/$2 * 100}'
echo ""

# --- Disk Usage ---
echo "🔹 Disk Usage (Root Partition):"
df -h / | awk 'NR==2 {print "Used: "$3" / Total: "$2" ("$5" used)"}'
echo ""

# --- Top 5 Processes by CPU ---
echo "🔹 Top 5 Processes by CPU usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
echo ""

# --- Top 5 Processes by Memory ---
echo "🔹 Top 5 Processes by Memory usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
echo ""

# --- Optional extra stats ---
echo "========================================"
echo "📊 Extra Stats"
echo "========================================"
echo "OS Version: $(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '\"')"
echo "Uptime: $(uptime -p)"
echo "Load Average: $(uptime | awk -F'load average:' '{print $2}')"
echo "Logged-in Users: $(who | wc -l)"
echo ""

echo "✅ Script execution completed."
