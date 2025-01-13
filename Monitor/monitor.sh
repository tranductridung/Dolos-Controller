#!/bin/bash

# Path to the log file
LOG_FILE="system_metrics.log"
REMOTE_USER="tridung"                # Tên người dùng trên máy nhận
REMOTE_HOST="192.168.18.130"   # Địa chỉ IP của máy chủ
REMOTE_PATH="/home/tridung/Desktop/Dolos-Controller/Monitor/monitor_log.txt"  # Đường dẫn thư mục trên máy nhận

# Lấy địa chỉ IP của máy giám sát
LOCAL_IP=$(hostname -I | awk '{print $1}')  # Lấy địa chỉ IP đầu tiên

# Logging loop every 10 seconds
while true; do
    TIMESTAMP=$(date +"%Y-%m-%dT%H:%M:%S%z")  # ISO 8601 format with timezone
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
    RAM_USAGE=$(free -m | awk '/Mem:/ {print $3}')
    DISK_STATS=$(iostat -d -k 1 1 | awk '/^sd/ {r+=$3; w+=$4} END {print r "," w}')
    DISK_READ=$(echo $DISK_STATS | cut -d ',' -f1)
    DISK_WRITE=$(echo $DISK_STATS | cut -d ',' -f2)

    # Using ifstat to get network information
    NETWORK_STATS=$(ifstat -i ens33 0.1 1 | tail -1 | awk '{print $1 "," $2}')
    NETWORK_RECEIVE=$(echo $NETWORK_STATS | cut -d ',' -f1)
    NETWORK_TRANSMIT=$(echo $NETWORK_STATS | cut -d ',' -f2)

    # Write the log entry with the IP address included
    echo "Timestamp=$TIMESTAMP, IP_Address=$LOCAL_IP, CPU_Usage=$CPU_USAGE%, RAM_Usage=${RAM_USAGE}MB, Disk_Read=${DISK_READ}KB/s, Disk_Write=${DISK_WRITE}KB/s, Network_Receive=${NETWORK_RECEIVE}KB/s, Network_Transmit=${NETWORK_TRANSMIT}KB/s" >> $LOG_FILE

    # Sync the log file to the remote server
    rsync -avz -e "ssh -p 22" $LOG_FILE $REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH

    # Wait for 5 seconds
    sleep 5
done

