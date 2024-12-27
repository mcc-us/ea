#!/bin/bash

touch 3.test.md

# Get all the pdf files in the current directory
pdf_files=( *.pdf )

# Open the file to write the filenames
echo "" > 3.test.md  # This will clear the content of the file before writing

# Loop through the pdf files and write the filename to the file
for file in "${pdf_files[@]}"
do
  # Get the filename without the extension
#  filename="${file%.*}"
  
  # Extract the Subject from pdfinfo output
  subject=$(pdfinfo "$file" 2>/dev/null | awk '/^Subject:/ {sub(/^Subject:\s+/,"",$1); print $1}')

  # Check if subject was successfully extracted
  if [ -z "$subject" ]; then
    subject="Subject Not Found" 
  fi

  # Write the filename to the file
  echo "$filename" >> 3.test.md
done
