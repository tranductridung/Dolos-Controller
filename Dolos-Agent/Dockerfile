FROM ubuntu:latest

RUN apt update && apt install -y software-properties-common

RUN add-apt-repository ppa:deadsnakes/ppa -y

RUN apt update && apt install -y \
    python3.7 \
    python3.7-dev \
    build-essential \
    iptables  \
    sqlite3 \
    endlessh \
    && rm -rf /var/lib/apt/lists/*

COPY agent /agent

RUN chmod +x /agent/agent
RUN chmod +x /agent/run.sh

CMD ["/bin/bash"]
