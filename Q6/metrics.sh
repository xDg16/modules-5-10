 
#!/bin/bash

# Check if input.txt exists and is readable
if [ ! -r "input.txt" ]; then
    echo "Error: input.txt not found or not readable."
    exit 1
fi

# Convert text to one word per line (remove punctuation, make lowercase)
words=$(tr -c 'A-Za-z' '\n' < input.txt | tr 'A-Z' 'a-z' | grep -v '^$')

# Longest word
longest=$(echo "$words" | awk '{ print length, $0 }' | sort -nr | head -n 1 | cut -d" " -f2)

# Shortest word
shortest=$(echo "$words" | awk '{ print length, $0 }' | sort -n | head -n 1 | cut -d" " -f2)

# Average word length
avg=$(echo "$words" | awk '{ total+=length; count++ } END { if(count>0) print total/count }')

# Total number of unique words
unique=$(echo "$words" | sort | uniq | wc -l)

echo "Text Metrics Report"
echo "-------------------"
echo "Longest word: $longest"
echo "Shortest word: $shortest"
echo "Average word length: $avg"
echo "Total unique words: $unique"
