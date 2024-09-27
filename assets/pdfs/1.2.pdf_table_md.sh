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
content+="| filename | Subject |\n"
content+="|---|---| \n"  # Separator line

# Get all PDF files in the current directory
pdf_files=( *.pdf )

# Loop through each PDF file
for pdf_file in "${pdf_files[@]}"
do
  # Extract filename without extension
  filename="${pdf_file%.*}"

  # Get subject using pdfinfo and regular expression
  subject=$(pdfinfo "$pdf_file" | grep -o 'Subject: \([^)]*\)' | sed 's/Subject: \(//; s/\)//')

  # Check if subject was found
  if [[ -z "$subject" ]]; then
    subject="Subject not found"
  fi

  # Escape special characters in subject for markdown
  escaped_subject=$(echo "$subject" | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g')

  # Append table row to content
  content+="| $filename | $escaped_subject |\n"
done

# Write the final content to the markdown file
echo -e "$content" >> "$output_file"

echo "Markdown table created in: $output_file"
