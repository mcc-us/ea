#!/bin/bash

file="income.assets.md"

# Remove lines that start with"
sed -i '/^Study Unit/d' "$file"   # del begin with 'Study Unit'
sed -i '/^This question is/d' "$file"   # del begin with 'This question is'
sed -i '/^[1-9][0-9]?. Question ID/d' "$file" # del lines that have 'num. Question ID'
sed -i '/^$/d' "$file" # Del blank lines

# Replace TEXT Phrases
sed -i "s/\"/'/g" "$file"

sed -i "s/Correct Answer Explanation for //g" "$file"

sed -i 's/\(correct\|wrong\)$//' "$file"

sed -i "s/United States/US/g" "$file"

sed -i "s/U\.S\./US/g" "$file"

#sed -i "s/_Internal\.Revenue\.Service/IRS/g" "$file"

#sed -i "s/ before the Internal Revenue Service//g" "$file"

echo "Complete"
