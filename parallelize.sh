#!/bin/bash

# This script takes runs a single command multiple times in parallel with different inputs.
# Examples
# ./script.sh item1 item2 item3 item4
# ./script.sh -c "process.sh" item1 item2 item3
# ./script.sh -f
# ./script.sh -c "process.sh" -f

# Default command if none specified
COMMAND="echo"
# Default items if using internal list
DEFAULT_ITEMS=("item1" "item2" "item3" "item4")

usage() {
    echo "Usage: $0 [-c command] [item1 item2 ...] OR"
    echo "       $0 [-c command] -f (to read items from script)"
    echo "Example: $0 -c 'echo' item1 item2 item3"
    exit 1
}

# Parse command line options
while getopts "c:fh" opt; do
    case $opt in
        c) COMMAND="$OPTARG";;
        f) USE_DEFAULT=true;;
        h) usage;;
        \?) usage;;
    esac
done

# Shift past the options
shift $((OPTIND-1))

# Get items either from command line or default list
if [ "$USE_DEFAULT" = true ]; then
    ITEMS=("${DEFAULT_ITEMS[@]}")
else
    if [ $# -eq 0 ]; then
        echo "Error: No items provided"
        usage
    fi
    ITEMS=("$@")
fi

# Get the number of items for parallel processing
PARALLEL_COUNT=${#ITEMS[@]}

# Run commands in parallel
printf "%s\n" "${ITEMS[@]}" | xargs -P "$PARALLEL_COUNT" -I {} $COMMAND {}

# Wait for all processes to complete
wait

