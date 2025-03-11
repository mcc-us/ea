#!/bin/bash

output_file="1.pdf_subject.txt"
touch "$output_file"

# Find all PDF files in the current directory
pdf_files=$(find . -maxdepth 1 -type f -name "*.pdf")

content=""

for pdf_file in $pdf_files; do
  # Extract filename without extension
  filename="${pdf_file##*/}"
  filename="${filename%.*}"

  # Get subject using pdfinfo
  subject=$(pdfinfo "$pdf_file" | grep "Subject: " | cut -d ':' -f 2-)

  # Substitute spaces in Subject to hyphens
  subject=$(echo "$subject" | tr ' ' '-')

  # Remove multiple consecutive hyphens
  subject=$(echo "$subject" | sed 's/--*/-/g')

  # Append table row to content
  content+="$filename$subject\n"
done

# Write the final content to the markdown file
echo -e "$content" > "$output_file"
echo "FINI"
