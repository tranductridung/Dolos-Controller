#!/bin/bash

ENDLESSH_PORTS=("$@")

ENDLESSH_JOBS=()

for PORT in "${ENDLESSH_PORTS[@]}"; do
    endlessh -p $PORT &
    ENDLESSH_JOBS+=($!)
done

./agent

for PID in "${ENDLESSH_JOBS[@]}"; do
    kill $PID
done
exit 0



