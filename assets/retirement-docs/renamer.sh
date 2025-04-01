#!/bin/bash

# Find all PDF files in the current directory and store them in an array
pdf_files=$(find . -maxdepth 1 -type f -name "*.pdf")
IFS=$'\n' read -r -d '' -a pdf_array <<< "$pdf_files"

# Loop through each PDF file
for pdf_file in "${pdf_array[@]}"; do
  # Get the filename without the extension
  pub_name=$(basename "$pdf_file" .pdf)

  # Read the "Subject" using pdfinfo
  subject_info=$(pdfinfo "$pdf_file" | grep "Subject:")
  subject_name=$(echo "$subject_info" | sed -e 's/Subject:[[:space:]]*//' -e 's/[[:space:]]*$//')

  # Sanitize subject_name to remove problematic characters for filenames
  subject_name=$(echo "$subject_name" | sed 's/[^a-zA-Z0-9._-]//g')

  # Construct the new filename
  new_name="${pub_name}.${subject_name}.pdf"

  # Check if it's the first PDF file in the loop to make a copy
  if [[ "$pdf_file" == "${pdf_array[0]}" ]]; then
    cp "$pdf_file" "$new_name"
    echo "Copied and renamed: '$pdf_file' to '$new_name'"
  else
    # Rename the current PDF file
    mv "$pdf_file" "$new_name"
    echo "Renamed: '$pdf_file' to '$new_name'"
  fi
done

echo "Finished processing PDF files."
