
#!/bin/bash

# Check if exactly one argument is provided
if [ "$#" -ne 1 ]; then
    echo "Error: Please provide exactly one log file name."
    exit 1
fi

logfile="$1"

# Check if file exists and is readable
if [ ! -e "$logfile" ]; then
    echo "Error: File does not exist."
    exit 1
fi

if [ ! -r "$logfile" ]; then
    echo "Error: File is not readable."
    exit 1
fi

# Count total entries
total_entries=$(wc -l < "$logfile")

# Count levels
info_count=$(grep -c " INFO " "$logfile")
warning_count=$(grep -c " WARNING " "$logfile")
error_count=$(grep -c " ERROR " "$logfile")

# Get most recent ERROR message
recent_error=$(grep " ERROR " "$logfile" | tail -n 1)

if [ -z "$recent_error" ]; then
    recent_error="No ERROR messages found."
fi

# Generate report file name
date_str=$(date +%Y-%m-%d)
report_file="logsummary_${date_str}.txt"

# Write report
{
    echo "Log Summary Report - $date_str"
    echo "----------------------------"
    echo "Total log entries: $total_entries"
    echo "INFO messages: $info_count"
    echo "WARNING messages: $warning_count"
    echo "ERROR messages: $error_count"
    echo
    echo "Most recent ERROR message:"
    echo "$recent_error"
} > "$report_file"

# Display results
cat "$report_file"

echo
echo "Report generated: $report_file"
