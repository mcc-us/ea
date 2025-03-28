#!/bin/bash

mkdir "1.pmd"
output_dir="1.pmd"

# Ensure the output directory exists
if [ ! -d "$output_dir" ]; then
  mkdir -p "$output_dir"
fi

# Loop through all PDF files in the current directory
for filename in *.pdf; do
  # Extract the filename without the extension
  filename_no_ext="${filename%.pdf}"

  # Create the markdown file in the output directory
  markdown_file="$output_dir/$filename_no_ext.md"

  # If the markdown file already exists, skip or overwrite
  if [ -f "$markdown_file" ]; then
    echo "$markdown_file already exists. Skipping..."
    continue
  fi

  # Build the markdown content
  content="---\n"
  content+="layout: post\n"
  content+="title: $filename_no_ext\n"
  content+="---\n\n"
  content+="<div class=\"pdf-container\">\n"
  content+="<iframe src=\"/ea/assets/pdfs/$filename\" height=\"600\" width=\"90%\" allowFullScreen=\"true\"></iframe>\n"
  content+="</div>\n"

  # Write the content to the markdown file in the output directory
  echo -e "$content" > "$markdown_file"
done

echo "Fini"

