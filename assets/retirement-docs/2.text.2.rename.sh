#!/bin/bash

# Input text file
text_file="11.PDF.subjects.txt"

# String to compare against
compare_string="p17-2024"

# Check if the file exists
if [[ ! -f "$text_file" ]]; then
  echo "ERROR: $text_file' not found."
  exit 1
fi

# Read the first line and store it in 'full_name'
full_name=$(head -n 1 "$text_file")

# Extract the first column before the hyphen using awk
first_column=$(echo "$full_name" | awk -F'--' '{print $1}')

# Compare the first column with the compare string
if [[ "$first_column" == "$compare_string" ]]; then
  echo "Match found: First column '$first_column' matches '$compare_string'"
  # Add further actions if a match is found
else
  echo "No match: First column '$first_column' does not match '$compare_string'"
  # Add further actions if no match is found
fi

# Example additional actions, if needed:
# if [[ "$first_column" == "$compare_string" ]]; then
#   # Do something if the first column matches
#   echo "Performing action for match..."
#   # ... your commands here ...
# else
#   # Do something if the first column does not match
#   echo "Performing action for no match..."
#   # ... your commands here ...
# fi
