#!/bin/bash

# 1. PRODUCE PDF/Name markdown file

# Define & Create the empty markdown file
output_file="2000-part1-misc.pubs.md"
touch "$output_file"

# Build header content
content="---\n"
content+="layout: post\n"
content+="title: Part1 Misc. Pubs\n"
content+="---\n\n"
content+="<script> function button1() { window.open("https://www.irs.gov/forms-pubs"); } </script>\n"
content+="<button onclick=\"button1()\">Goto IRS Pubs</button>\n\n"
content+="| Doc # | Title |\n"
content+="|:--|:--|\n"

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
  content+="| [$filename](/ea/pmd/view.$filename) | $subject |\n"
done

# Write the final content to the markdown file
echo -e "$content" >> "$output_file"
echo "Table complete"

#-----------------------------------

# Define the filename
#file=$output_file

# Check if the file exists
#if [ ! -f "$file" ]; then
#  echo "Error: File '$file' not found!"
#  exit 1
#fi

#-----------------------------------------

# 2. REPLACE STRINGS
# Perform the replacement using sed with in-place editing (-i) flag

sed -i 's/Subject:         //' "$output_file"
sed -i 's/Instructions for /Ins: /' "$output_file"
sed -i 's/Instructions /Ins: /' "$output_file"
sed -i 's/U.S.//' "$output_file"
sed -i 's/United States//' "$output_file"
sed -i 's/ and / \& /' "$output_file"
sed -i 's/ Application / App. /' "$output_file"
sed -i 's/ Additional / Addn /' "$output_file"
sed -i 's/Individual Retirement Arrangements (IRAs)/IRAs/' "$output_file"
sed -i 's/Identification/ID/' "$output_file"

#sed -i 's/(American Opportunity  and  Lifetime Learning Credits)/AOTC & LLC/' "$file"

#Application
#sed -i "s/"_Internal.Revenue.Service"/""/g" "$file"
#sed -i "s/" before the Internal Revenue Service"/""/g" "$file"

echo "FINI"
