#!/bin/bash

# Usage:
# Redirect input from a file:
# Bash

# ./script.sh < input.txt

# Use code with caution.
# Pipe input from another command:
# Bash

# cat input.txt | ./script.sh

#------------------------------

# Get the desired output file name
# Enter the desired output file name:
output_file="no.question.text.txt"


# Function to process a single line
process_line() {
  local line="$1"

   if [[ $line =~ ^[0-9]+\. ]] || [[ $line =~ ^'Question ID:' ]] ; then
  #if [[ $line =~ ^[0-9]+\. ]] || [[ $line =~ ^Question ID: ]] ; then
    # Remove initial number and "Question ID:   "
    line="${line#*[0-9]. }"
    line="${line#Question ID:   }"

    # Extract the topic and remove the closing parenthesis
    topic="${line#*Topic:   }"
    topic="${topic%)*}"

    echo "$topic"
  else
    # Keep the line unchanged
    echo "$line"
  fi
}

# Redirect output to the specified file
while read line; do
  process_line "$line" >> "$output_file"
done
