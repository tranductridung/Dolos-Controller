#!/bin/bash

# Đọc danh sách các cổng từ file ports.txt
ENDLESSH_PORTS=("$@")

# Mảng để lưu PID của các tiến trình endlessh
ENDLESSH_JOBS=()

# Định nghĩa hàm để dừng các tiến trình khi nhận tín hiệu SIGINT (Ctrl+C)
cleanup() {
    echo "Đang dừng tất cả tiến trình endlessh..."
    for PID in "${ENDLESSH_JOBS[@]}"; do
        kill -9 $PID  # Dừng tiến trình bằng PID
    done
    exit 0
}

# Bắt tín hiệu SIGINT (Ctrl+C) và gọi hàm cleanup
trap cleanup SIGINT

# Chạy endlessh chỉ trên các cổng trong ENDLESSH_PORTS
for PORT in "${ENDLESSH_PORTS[@]}"; do
    endlessh -p $PORT &  # Chạy endlessh trên mỗi cổng
    ENDLESSH_JOBS+=($!)   # Lưu PID của mỗi tiến trình endlessh
done

# Giữ script đang chạy cho đến khi nhận tín hiệu SIGINT (Ctrl+C)
wait

