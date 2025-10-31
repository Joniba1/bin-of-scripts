#!/usr/bin/env bash
# killport - Kill a process using a specific port (TCP by default)
# Usage: killport <port> [-f|--force] [-u|--udp]
# Example: killport 3000

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Parse command line arguments
force=0
udp=0
port=""

# Cleanup function
cleanup() {
    echo -e "${RED}Aborting${NC}"
    exit 1
}

# Parse port
if [[ $# -gt 0 ]]; then
    port=$1
else
    echo "Usage: killport <port> [-f|--force] [-u|--udp]" >&2
    exit 1
fi

# Validate port number
if ! [[ "$port" =~ ^[0-9]+$ ]] || ! ((port >= 1 && port <= 65535)); then
    echo -e "${RED}Invalid port number: $port${NC}" >&2
    exit 1
elif ((port <= 1023)); then
    echo -e "${RED}Port $port is a system port and cannot be killed${NC}" >&2
    exit 1
fi

# Parse flags
shift
while [[ $# -gt 0 ]]; do
    case $1 in
        -f|--force)
            force=1
            ;;
        -u|--udp)
            udp=1
            ;;
        *)
            echo -e "${RED}Invalid argument: $1${NC}" >&2
            exit 1
            ;;
    esac
    shift
done

# Set traps for safe exit
trap cleanup SIGINT SIGTERM

# Check dependencies
if ! command -v lsof >/dev/null 2>&1 || ! command -v kill >/dev/null 2>&1; then
    echo -e "${RED}Error: 'lsof' and 'kill' commands are required${NC}" >&2
    exit 1
fi

# Build commands
if [[ $udp -eq 1 ]]; then
    command="lsof -n -i udp:$port"
else
    command="lsof -n -i tcp:$port"
fi

kill_command="kill"
if [[ $force -eq 1 ]]; then
    kill_command="kill -9"
fi

# Get PIDs and show process table
process_table=$(eval "$command" 2>/dev/null)
pids=$(echo "$process_table" | awk 'NR>1 {print $2}' | sort -u)

if [[ -z "$pids" ]]; then
    echo -e "${YELLOW}No process is using port $port${NC}"
    exit 0
fi

# Show the processes first
echo -e "${YELLOW}The following process(es) are using port $port:${NC}"
echo "$process_table"

# Kill processes
for pid in $pids; do
    if eval "$kill_command $pid" 2>/dev/null; then
        echo -e "PID ${YELLOW}$pid${NC} killed"
    else
        echo -e "${RED}Error: Failed to kill PID $pid${NC}" >&2
    fi
done

echo -e "${GREEN}Done${NC}"
