#!/bin/bash


# Usage:
# Redirect input from a file:

# ./script.sh < input.txt

# OR
# Pipe input from another command:

# cat input.txt | ./script.sh

#------------------------------

# Enter the desired output file name:
output_file="no.questions.txt"

# Function to process a single line
process_line() {
  local line="$1"

  if [[ $line =~ ^[0-9]+\. ]] || [[ $line =~ ^Question ID: ]] ; then
    # Remove initial number and "Question ID:   "
    line="${line#*[0-9]. }"
    line="${line#Question ID:   }"

    # Remove the closing parenthesis
    line="${line%)*}"

    echo "$line"
  else
    # Keep the line unchanged
    echo "$line"
  fi
}

# Redirect output to the specified file
while read line; do
  process_line "$line" >> "$output_file"
done
