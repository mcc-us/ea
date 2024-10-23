#!/bin/bash

# 1. PRODUCE PDF/Name markdown file

# Define the output filename
output_file="1.pdf2table.md"

# Create the empty markdown file
touch "$output_file"

# Build header content
content="---\n"
content+="layout: post\n"
content+="title: IRS Documents\n"
content+="---\n\n"
content+="<script> function button1() { window.open("https://www.irs.gov/forms-pubs"); } </script>\n"
content+="<button onclick=\"button1()\">Goto IRS Pubs</button>\n\n"
content+="| Doc # | Title |\n"
content+="|:--|:--|\n"  # Table separator line

# Get list of all PDF files in the current directory
pdf_files=( *.pdf )
echo ${#pdf_files[@]}

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
echo "CREATED TABLE"

#-----------------------------------

# Define the filename
file="1.pdf2table.md"

# Check if the file exists
if [ ! -f "$file" ]; then
  echo "Error: File '$file' not found!"
  exit 1
fi

#-----------------------------------------

# 2. REPLACE STRINGS

# Replace: "Subject:         "
old_string="Subject:         "
new_string=""  # null string

# Perform the replacement using sed with in-place editing (-i) flag
sed -i "s/$old_string/$new_string/g" "$file"

#---------------------------------------------

# Replace: "Instructions for "
old_string="Instructions for "
new_string="Instructions:"

# Perform the replacement using sed with in-place editing (-i) flag
sed -i "s/$old_string/$new_string/g" "$file"

#---------------------------------------------

# Replace TEXT Phrases
sed -i "s/"U.S."/"US"/g" "$file"
sed -i "s/"United States"/"US"/g" "$file"
#sed -i "s/"_Internal.Revenue.Service"/""/g" "$file"
#sed -i "s/" and "/" & "/g" "$file"
sed -i "s/" before the Internal Revenue Service"/""/g" "$file"


echo "FINI"
