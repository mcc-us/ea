#!/bin/bash

# Iterate thru all PDF files in a directory
for file in *.pdf; do
  # Extract filename w/o extension
  filename="${file%.*}"

  # Get the PDF subject via pdfinfo
  title=$(pdfinfo "$file" 2>/dev/null | grep "Subject:" |\
  tr '[:space:]' '.' |\
  tr -d '/\\:*?"&<>,|' |\ 
  tr -d 'Subject:' '.' )
  echo $title
  
  # IF Subject is empty, "no.name"
  if [ -z "$title" ]; then
      title="NoName"
  fi

  # Create the new filename by appending the sanitized title
  new_filename="${filename}-${title}.pdf"

  # Copy/Rename file
  if [ ! -f "$new_filename" ]; then
    cp "$file" "$new_filename"
    echo -e "$new_filename" > 1.text_file.txt
  else
    echo "rename fail"
    echo -e "$new_filename" > 1.text_file.txt
  fi
  
done

echo "FINI"
