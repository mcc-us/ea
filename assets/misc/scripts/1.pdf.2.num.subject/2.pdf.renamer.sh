#!/bin/bash

# Get a list of all PDF files in the current directory
pdf_files=$(find . -maxdepth 1 -type f -name "*.pdf")

# Loop through each PDF file
while IFS= read -r file; do
  # Get the filename without the extension as 'doc_num'
  doc_num="${file##*/}"
  doc_num="${doc_num%.*}"

  # Use pdfinfo to find the subject of the PDF
  sec_title=$(pdfinfo "$file" 2>/dev/null | grep "Subject:" |\
  cut -d':' -f2 |\
  sed 's/Instructions//g' |\
  sed 's/ Form //g' |\
  sed 's/ 8995 //g' |\
  sed 's/Individuals//g' |\
  sed 's/Simplified//g' |\
  sed 's/Computation//g' |\
  tr ' ' '.' |\
  tr ',' '.' )
  
  #tr 'Instructions.for.Form.8995' '.' |\
  #sed 's/[(|\/,;:`"+\-)]//g')
  
  # Construct the new filename
  new_filename="${doc_num}-${sec_title}.pdf"

  # Check if the new filename is the same as the old filename
  if [ "$file" != "./$new_filename" ]; then
    # Copy the original file to the new name
    cp "$file" "$new_filename"
  fi
  
done <<< "$pdf_files"

echo "FINI"
