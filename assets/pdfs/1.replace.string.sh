#!/bin/bash

# Define the filename
file="1.pdf2table.md"

# Define the strings to replace
old_string="Subject:         "
new_string=""  # Empty string to replace with

# Check if the file exists
if [ ! -f "$file" ]; then
  echo "Error: File '$file' not found!"
  exit 1
fi

# Perform the replacement using sed with in-place editing (-i) flag
sed -i "s/$old_string/$new_string/g" "$file"

#---------------------------------------------
# Define the strings to replace, PHASE 1
old_string="Instructions for "
new_string="Instructions:"  # Empty string to replace with

# Perform the replacement using sed with in-place editing (-i) flag
sed -i "s/$old_string/$new_string/g" "$file"

# Perform the replacement using sed with in-place editing (-i) flag
sed -i "s/"U.S."/"US"/g" "$file"

# Inform about completion
echo "Success"