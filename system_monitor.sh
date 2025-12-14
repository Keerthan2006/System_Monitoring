#!/bin/bash
###########################################################
# Author : Keerthan
# Date   : 2023-10-05
# Description : System Monitoring Script
###########################################################
# Defining Threshold Values
CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
DISK_THRESHOLD=80

# Function to send alert
send_alert(){
    echo ALERT: $1 usage is above threshold value : $2%
}
# Continuous Monitoring of CPU , Memory and Disk Usage
while true; do
    # CPU Monitoring
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
    CPU_USAGE=${CPU_USAGE%.*}
    if [ $CPU_USAGE -gt $CPU_THRESHOLD ]; then
        send_alert "CPU" $CPU_USAGE
    fi
done

