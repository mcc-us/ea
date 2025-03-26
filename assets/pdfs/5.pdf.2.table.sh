#!/bin/bash

# 1. PRODUCE PDF/Name markdown file

# Define & Create the empty markdown file
output_file="1-pdfs-table.md"
touch "$output_file"

# Build header content
content="---\n"
content+="layout: post\n"
content+="title: PDFs On File\n"
content+="---\n\n"
content+="<script> function button1() { window.open(\"https://www.irs.gov/forms-pubs\"); } </script>\n"
content+="<button onclick=\"button1()\">Goto IRS Pubs</button>\n\n"
content+="| # | Doc Title |\n"
content+="|:--:|:--|\n"

# Get list of all PDF files in the current directory and sort them
mapfile -t pdf_files < <(ls *.pdf | sort)

echo "Total PDFs found: ${#pdf_files[@]}"

# Loop through each sorted PDF file with index
index=1
for pdf_file in "${pdf_files[@]}"
do
  # Extract filename without extension
  filename="${pdf_file%.*}"

  # Append table row to content
  content+="| $index | [$filename](/ea/pdf-2-md/$filename) |\n"
  ((index++))
done

# Write the final content to the markdown file
echo -e "$content" > "$output_file"
echo "Table complete"

echo "FINI"

