#!/bin/bash

# Đọc danh sách các cổng từ file ports.txt
ENDLESSH_PORTS=("$@")

# Mảng để lưu PID của các tiến trình endlessh
ENDLESSH_JOBS=()

# Chạy endlessh chỉ trên các cổng trong ENDLESSH_PORTS
for PORT in "${ENDLESSH_PORTS[@]}"; do
    endlessh -p $PORT &  # Chạy endlessh trên mỗi cổng
    ENDLESSH_JOBS+=($!)   # Lưu PID của mỗi tiến trình endlessh
done

sleep 30

for PID in "${ENDLESSH_JOBS[@]}"; do
    kill $PID  # Dừng tiến trình bằng PID
done
exit 0



