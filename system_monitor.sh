#!/bin/bash
###########################################################
# Author : Keerthan
# Date   : 2023-10-05
# Description : System Monitoring Script
# Execution : bash system_monitor.sh
# Permission are 755
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
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $3}')
    CPU_USAGE=${CPU_USAGE%.*}
    if [ $CPU_USAGE -gt $CPU_THRESHOLD ]; then
        send_alert "CPU" $CPU_USAGE
    fi
    # Memory Monitoring
    MEMORY_USAGE=$(free | grep "Mem:" | awk '{print $3/$2 * 100.0}')
    MEMORY_USAGE=${MEMORY_USAGE%.*}
    if [ $MEMORY_USAGE -gt $MEMORY_THRESHOLD ]; then
    send_alert "Memory" $MEMORY_USAGE
    fi
    # Disk Monitoring
    DISK_USAGE=$(df / | grep / | awk '{ print $5 }' )
    DISK_USAGE=${DISK_USAGE%?}
    if [ $DISK_USAGE -gt $DISK_THRESHOLD ]; then
        send_alert "Disk" $DISK_USAGE
    fi
    # Final Values Of Usage
    echo CPU USAGE: $CPU_USAGE%
    echo MEMORY USAGE: $MEMORY_USAGE%
    echo DISK USAGE: $DISK_USAGE%
    # Sleep for 60 seconds before next check
    sleep 60
done

