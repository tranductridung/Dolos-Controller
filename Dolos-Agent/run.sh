#!/bin/bash

CONTAINER_NAME="agent"

PORTS="$@"
endlessh_ports="${2:-}"   # Chuỗi các port từ endlessh_ports

# Chuyển đổi chuỗi thành mảng
IFS=' ' read -r -a port_array <<< "$PORTS"
IFS=' ' read -r -a endlessh_ports_array <<< "$endlessh_ports"

PORT_ARGS=""
for PORT in "${port_array[@]}"; do
    PORT_ARGS+="-p $PORT:$PORT "
done

sudo docker rm -f agent

sudo docker build -t $CONTAINER_NAME .

sudo apparmor_parser -r -W docker-network

sudo docker run --cap-add=NET_ADMIN --net=host --privileged -d -it $PORT_ARGS --security-opt apparmor=docker-network --name $CONTAINER_NAME $CONTAINER_NAME

sudo docker exec $CONTAINER_NAME /bin/bash -c "cd $CONTAINER_NAME && ./run.sh ${endlessh_ports_array[@]}"

