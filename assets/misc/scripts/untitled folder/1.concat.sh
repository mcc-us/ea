#!/bin/bash

# Find all .md files in the current directory
find . -name "*.md" | while read file; do
  # Skip the first 3 lines (YAML header)
  tail -n +4 "$file" >> 1.total.csv
done


#find . -name "*.md" | while read file; do
#  sed -i '1,/---/d' "$file"
#  cat "$file" >> 1.total.csv
#done
