#!/bin/bash

# Input and output filenames
input_file="1.total.csv"
output_file="2.clean.txt"

# Find all .md files in the current directory
find . -name "*.md" | while read file; do
  # Skip the first 4 lines (YAML header)
  tail -n +5 "$file" >> 1.total.csv
done

# Use sed to filter lines in a single command
sed '/^---/d; /^title:/d; /^layout:/d; /^Study Unit/d; /^This question/d; /^<hr class/d; s/\*\*//g' "$input_file" > "$output_file"

# Optional message (uncomment if desired)
echo "Cleaning complete"
