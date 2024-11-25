#!/bin/bash

# Input and output filenames
input_file="q4-Tax-Payer-Filing-Separately.md"
output_file="2.clean.txt"

# Use sed to filter-out lines starting with X.
clean_command="sed '/^---/d' "$input_file" | \
sed '/^title:/d' | \
sed '/^layout:/d' | \
sed '/^Study Unit/d' | \
sed '/^This question/d' \
sed 's/\*\*/""/g'" \
#sed '/^<hr class=/d'"

eval $clean_command > $output_file

# Optional message (uncomment if desired)
echo "Cleaning complete"
