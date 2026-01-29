

#!/bin/bash

# Check if emails.txt exists and is readable
if [ ! -r "emails.txt" ]; then
    echo "Error: emails.txt not found or not readable."
    exit 1
fi

# Extract valid email addresses
grep -E '^[A-Za-z0-9]+@[A-Za-z]+\.com$' emails.txt > valid.txt

# Remove duplicates from valid.txt
sort valid.txt | uniq > temp.txt
mv temp.txt valid.txt

# Extract invalid email addresses
grep -vE '^[A-Za-z0-9]+@[A-Za-z]+\.com$' emails.txt > invalid.txt

echo "Processing complete."
echo "Valid emails saved in valid.txt"
echo "Invalid emails saved in invalid.txt"
