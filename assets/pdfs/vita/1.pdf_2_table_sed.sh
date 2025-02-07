#!/bin/bash

# 1. PRODUCE PDF/Name markdown file

# Define the output filename
output_file="3000-vita.guides.md"

# Create the empty markdown file
touch "$output_file"

# Build header content
content="---\n"
content+="layout: post\n"
content+="title: VITA Guides\n"
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
#echo "CREATED TABLE"

#-----------------------------------

# Check if the file exists
#if [ ! -f "$output_file" ]; then
#  echo "Error: File "$output_file" not found!"
#  exit 1
#fi

#-----------------------------------------

# 2. REPLACE STRINGS
#sed 's/unix/linux/' geekfile.txt 
# Perform the replacement using sed with in-place editing (-i) flag

sed -i 's/Subject:         //' "$output_file"
sed -i 's/ (English-Spanish)//' "$output_file"
#sed -i 's/ and / \& /' "$output_file"
#sed -i 's/VITA\/TCE INTAKE\/INTERVIEW AND QUALITY REVIEW TRAINING/VITA Intake Interview & Quality Training/g' "$output_file"

awk '{gsub(/VITA\/TCE INTAKE\/INTERVIEW AND QUALITY REVIEW TRAINING/, "VITA Intake Interview & Quality Training")}1' 2024-12-01-vita.guides.md > temp_file.txt
mv temp_file.txt 2024-12-01-vita.guides.md

#sed -i 's/\|  \|"/\| VITA Intro \|/' "$output_file"  ### effs up the first col.

#sed -i 's/"VITA/TCE INTAKE/INTERVIEW AND QUALITY REVIEW TRAINING"/"VITA/TCE Intake/Intview & Quality Training"/g' "$file"
#sed -i 's/VITA\/TCE INTAKE\/INTERVIEW AND QUALITY REVIEW TRAINING/VITA\/TCE Intake\/Intview & Quality Training/g' file.txt
#sed -i 's/"Instructions for "/"Inst.:"/g' "$file"
#sed -i 's/U.S.//g' "$file"
#sed -i "s/"United States"//g" "$file"
#sed -i "s/"_Internal.Revenue.Service"//g" "$file"
#sed -i "s/" and "/" & "/g" "$file"
#sed -i "s/" before the Internal Revenue Service"/""/g" "$file"


#sed -i "s/"|  |"/"| VITA Intro |"/g" "$file"


echo "FINI"
