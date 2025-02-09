#!/bin/bash

# name final output file:
output_file="1.filtered.txt"

# Find all .md files in the current directory
find . -name "*.md" | while read file; do
  # Skip the first 3 lines (YAML header)
  tail -n +4 "$file" >> 1.total.csv
done

# Combine grep patterns with pipe for efficient filtering
grep -vE "^(Study Unit|This question is answered|---|<hr class=\"red\">|Example)" "$file" > "$output_file"

echo "Completed!"
