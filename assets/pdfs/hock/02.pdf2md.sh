#!/bin/bash


mkdir "1.pmd"
output_dir="1.pmd"

# Loop through all files in the current directory
for filename in *.pdf; do
  # Extract the filename without the extension
  filename_no_ext="${filename%.pdf}"

  # Create the markdown file in the output directory
  markdown_file="$output_dir/view.$filename_no_ext.md"
  touch "$markdown_file"

  # Build the markdown content
  content="---\n"
  content+="layout: post\n"
  content+="title: $filename_no_ext\n"
  content+="---\n\n"
  content+="<div class=\"pdf-container\">\n"
  content+="<iframe src=\"ea/assets/pdfs/hock/$filename\" height=\"600\" width=\"100%\" allowFullScreen=\"true\"></iframe>\n"
  content+="</div>\n"

  # Write the content to the markdown file in the output directory
  echo -e "$content" >> "$markdown_file"
done

echo "Created Markdown files in $output_dir for all PDF documents."
