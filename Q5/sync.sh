#!/bin/bash

# Check for exactly two arguments
if [ "$#" -ne 2 ]; then
    echo "Error: Please provide exactly two directory names."
    exit 1
fi

dirA="$1"
dirB="$2"

# Check if both are valid directories
if [ ! -d "$dirA" ] || [ ! -d "$dirB" ]; then
    echo "Error: One or both directories do not exist."
    exit 1
fi

echo "Files only in $dirA:"
echo "-------------------"
comm -23 <(ls "$dirA") <(ls "$dirB")

echo
echo "Files only in $dirB:"
echo "-------------------"
comm -13 <(ls "$dirA") <(ls "$dirB")

echo
echo "Common files with content comparison:"
echo "-------------------------------------"

for file in $(comm -12 <(ls "$dirA") <(ls "$dirB"))
do
    if cmp -s "$dirA/$file" "$dirB/$file"; then
        echo "$file : SAME content"
    else
        echo "$file : DIFFERENT content"
    fi
done
