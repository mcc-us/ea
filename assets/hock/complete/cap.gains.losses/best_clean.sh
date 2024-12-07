#!/bin/bash

cat *.txt >> cap.gains.md

file="cap.gains.md"

# Remove lines that start with"
sed -i '/^Study Unit/d' "$file"
sed -i '/^This question is/d' "$file"

# Replace TEXT Phrases
sed -i "s/\"/'/g" "$file"
sed -i "s/Correct Answer Explanation for /\",\"/g" "$file"
sed -i 's/\(correct\|wrong\)$//' "$file"
sed -i "s/United States/US/g" "$file"
sed -i "s/U\.S\./US/g" "$file"

sed -i 's/^[0-9]\{1,2\}\.*/"  "/' "$file"

sed -i '/^$/d' "$file"  # Remove empty lines
echo "Complete"
