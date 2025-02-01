#!/bin/bash

# Iterate through all PDF files in the current directory
for file in *.pdf; do
  # Extract the filename without the extension
  filename="${file%.*}"

  # Get the PDF title using pdfinfo, remove commas, and handle empty titles
  title=$(pdfinfo "$file" | grep "Subject:" | cut -d ':' -f 2 | tr -d ',' | tr -d '&' | xargs)

  # Handle cases where the title might be empty or not found.  Replace with "Untitled" if necessary.
  if [ -z "$title" ]; then
      title="Untitled"
  fi

  # Create the new filename by appending the sanitized title
  new_filename="${filename}-${sanitized_title}.pdf"

  # Rename the file.  Added a check to avoid overwriting existing files.
  if [ ! -f "$new_filename" ]; then
    mv "$file" "$new_filename"
    echo "Renamed '$file' to '$new_filename'"
  else
    echo "File '$new_filename' already exists. Skipping rename of '$file'"
  fi

done

echo "Finished processing PDF files."
