#!/bin/bash

# Define the output filename
output_file="1.pdf2table.md"

# Create the empty markdown file
touch "$output_file"

# Build initial content
content="---\n"
content+="layout: post\n"
content+="title: IRS Doc No & Title\n"
content+="---\n\n"
content+="<script> function button1() { window.open("https://www.irs.gov/forms-pubs"); } </script>\n"
content+="<button onclick="button1()">Goto IRS Pubs</button>\n\n"
content+="| Doc # | Title |\n"
content+="|---|---|\n"  # Separator line

# Get all PDF files in the current directory
pdf_files=( *.pdf )

# Loop through each PDF file
for pdf_file in "${pdf_files[@]}"
do
  # Extract filename without extension
  filename="${pdf_file%.*}"

  # Get subject using pdfinfo (may need adjustment for non-IRS PDFs)
  subject=$(pdfinfo "$pdf_file" | grep "Subject: ") 

  # Append table row to content
  content+="| [$filename](/ea/others/view.$filename) | $subject |\n"
done

# Write the final content to the markdown file
echo -e "$content" >> "$output_file"

echo "Fini"
