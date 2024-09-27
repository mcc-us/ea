#!/bin/bash

# Get a list of all PDF files in the current directory
pdf_files=$(find . -type f -name "*.pdf")

# Iterate over each PDF file
for pdf_file in $pdf_files; do
  # Extract the subject using pdfinfo
  subject=$(pdfinfo "$pdf_file" | grep -i "Subject:" | awk '{print $2}')

  # Check if subject is not empty
  if [[ -n "$subject" ]]; then
    # Print the subject
    echo "$subject"
  else
    # Handle empty subject (optional)
    echo "No subject found for $pdf_file"
  fi
done
