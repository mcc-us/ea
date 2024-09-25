#!/bin/bash

# Get the current directory
current_dir=$(pwd)

# Initialize the counter
counter=0

# Loop through all files in the current directory
for file in "$current_dir"/*.png; do
  # Extract the timestamp from the filename
  timestamp=$(basename "$file" | cut -d'_' -f2-)

  # Increment the counter
  counter=$((counter + 1))

  # Create the new filename
  new_filename="Q$(printf "%02d" "$counter")_$timestamp"

  # Rename the file
  mv "$file" "$new_filename"
done
