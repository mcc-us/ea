#!/bin/bash

# Input and output filenames
input_file="1.total.txt"
output_file="1.clean.txt"

# Find all .md files in the current directory
find . -name "*.md" | while read file; do
  # Skip the first 4 lines (YAML header)
  tail -n +5 "$file" >> 1.total.txt
done

# Use sed to filter out lines and make substitions
sed '/^---/d; /^title:/d; /^layout:/d; /^Study Unit/d; /^This question/d; /^<hr class/d; s/\*\*//g; s/^[0-9][0-9]?. Question ID: //' "$input_file" > "$output_file"

rm 1.total.txt

sed -i 's/\(correct\|wrong\)[[:space:]]*$/  /' "$output_file"
#sed -i 's/^[0-9]. Question ID: //' "$output_file"
sed -i 's/^### //' "$output_file"
sed -i 's/^#### //' "$output_file"

# Optional message (uncomment if desired)
echo "Concatentation & Cleaning complete"
