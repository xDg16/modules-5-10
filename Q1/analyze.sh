
#!/bin/bash

# Check if exactly one argument is given
if [ "$#" -ne 1 ]; then
    echo "Error: Please provide exactly one argument."
    exit 1
fi

path=$1

# Check if path exists
if [ ! -e "$path" ]; then
    echo "Error: Path does not exist."
    exit 1
fi

# If it is a file
if [ -f "$path" ]; then
    echo "It is a file."
    echo "Lines: $(wc -l < "$path")"
    echo "Words: $(wc -w < "$path")"
    echo "Characters: $(wc -c < "$path")"

# If it is a directory
elif [ -d "$path" ]; then
    echo "It is a directory."

    total_files=$(find "$path" -maxdepth 1 -type f | wc -l)
    txt_files=$(find "$path" -maxdepth 1 -type f -name "*.txt" | wc -l)

    echo "Total files: $total_files"
    echo "Number of .txt files: $txt_files"

else
    echo "Error: Invalid path type."
fi
