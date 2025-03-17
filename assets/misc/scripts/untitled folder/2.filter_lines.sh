#!/bin/bash

file="1.total.csv"
output_file="filtered_1.total.csv"

# More robust regular expression to match various "Question ID" formats
grep_patterns="^---"

if grep -q -E "$grep_patterns" "$file"; then
  echo "Found lines to remove. Processing..."
  grep -v -E "$grep_patterns" "$file" >> "$output_file"
  echo "Filtered lines written to $output_file"
else
  echo "No lines matching the specified patterns were found."
fi
