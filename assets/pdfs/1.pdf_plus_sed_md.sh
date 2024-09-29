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

#-----------------------------------

# Define the filename
file="1.pdf2table.md"

# Check if the file exists
if [ ! -f "$file" ]; then
  echo "Error: File '$file' not found!"
  exit 1
fi

#-----------------------------------------

# Define the strings to replace, PHASE 1
old_string="Subject:         "
new_string=""  # Empty string to replace with

# Perform the replacement using sed with in-place editing (-i) flag
sed -i "s/$old_string/$new_string/g" "$file"
#---------------------------------------------
# Define the strings to replace, PHASE 1
old_string="Instructions for "
new_string="Instructions:"  # Empty string to replace with

# Perform the replacement using sed with in-place editing (-i) flag
sed -i "s/$old_string/$new_string/g" "$file"

# Perform the replacement using sed with in-place editing (-i) flag
sed -i "s/"U.S."/"US"/g" "$file"


# Inform about completion
#echo "Successfully replaced '$old_string' with '$new_string' in '$file'"