 
#!/bin/bash

# Check if a file argument is provided
if [ "$#" -ne 1 ]; then
    echo "Error: Please provide exactly one input file."
    exit 1
fi

file="$1"

# Check if file exists and is readable
if [ ! -r "$file" ]; then
    echo "Error: File does not exist or is not readable."
    exit 1
fi

# Extract words (one per line), remove punctuation, ignore case
words=$(tr -c 'A-Za-z' '\n' < "$file" | tr 'A-Z' 'a-z' | grep -v '^$')

# Words containing ONLY vowels
echo "$words" | grep -E '^[aeiou]+$' > vowels.txt

# Words containing ONLY consonants
echo "$words" | grep -E '^[bcdfghjklmnpqrstvwxyz]+$' > consonants.txt

# Words containing both vowels and consonants but starting with a consonant
echo "$words" | grep -E '^[bcdfghjklmnpqrstvwxyz][a-z]*$' | grep -E '[aeiou]' > mixed.txt

echo "Processing complete."
echo "Output files created:"
echo "vowels.txt"
echo "consonants.txt"
echo "mixed.txt"

