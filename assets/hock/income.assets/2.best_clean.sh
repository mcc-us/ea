#!/bin/bash

cat *.txt >> 1.all.md

file="1.all.md"

# Remove lines that start with"
sed -i '/^Study Unit/d' "$file"
sed -i '/^This question is/d' "$file"

# Replace TEXT Phrases
sed -i "s/\"/'/g" "$file"



sed -i '/^[0-9].*Question ID/s/.*/" "/' "$file"



sed -i "s/Correct Answer Explanation for //g" "$file"

sed -i 's/\(correct\|wrong\)$//' "$file"

sed -i "s/United States/US/g" "$file"
sed -i "s/U\.S\./US/g" "$file"

sed -i '/^$/d' "$file"

echo "Complete"
