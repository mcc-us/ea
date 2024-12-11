#!/bin/bash

file="basis.inher.txt"

# Remove lines that start with"
sed -i '/^Study Unit/d' "$file"
sed -i '/^This question is/d' "$file"

# Replace TEXT Phrases
sed -i "s/\"/'/g" "$file"

sed -i "s/Correct Answer Explanation for //g" "$file"

sed -i 's/\(correct\|wrong\)$//' "$file"

sed -i "s/United States/US/g" "$file"
sed -i "s/U\.S\./US/g" "$file"

#sed -i "s/_Internal\.Revenue\.Service/IRS/g" "$file"

#sed -i "s/ before the Internal Revenue Service//g" "$file"

echo "Complete"
