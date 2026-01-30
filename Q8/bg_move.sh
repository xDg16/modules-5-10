#!/bin/bash

# Check if exactly one argument is given
if [ "$#" -ne 1 ]; then
    echo "Error: Please provide exactly one directory path."
    exit 1
fi

dir="$1"

# Check if directory exists
if [ ! -d "$dir" ]; then
    echo "Error: Directory does not exist."
    exit 1
fi

backup_dir="$dir/backup"

# Create backup directory if not exists
mkdir -p "$backup_dir"

echo "Main script PID: $$"
echo "Starting background move operations..."

# Loop through files in directory (excluding backup folder)
for file in "$dir"/*
do
    if [ -f "$file" ]; then
        mv "$file" "$backup_dir/" &
        pid=$!
        echo "Moving $(basename "$file") in background. PID = $pid"
    fi
done

echo "Waiting for all background processes to finish..."
wait

echo "All files moved successfully."
