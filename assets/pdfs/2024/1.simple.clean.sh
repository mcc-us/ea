#!/bin/bash

output_file="1.pdf_subject.txt"
touch "$output_file"

# Find all PDF files in the current directory
pdf_files=$(find . -type f -name "*.pdf")

content=""

for pdf_file in $pdf_files; do
  # Extract filename without extension
  filename="${pdf_file##*/}"
  filename="${filename%.*}"

  # Get subject using pdfinfo
  subject=$(pdfinfo "$pdf_file" | grep "Subject: " | cut -d ':' -f 2-)
  
  # Clean subject: remove double spaces, apply substitutions
  subject=$(echo "$subject" \
    | tr -d '[:punct:]' \
    | tr -d '\r' \
    | tr ' ' '-' \
    | sed 's/-and-/-/g' \
    | sed 's/US//g' \
    | sed 's/-Tax-/-/g' \
    | sed 's/-IRS-/-/g' \
    | sed 's/-Instructions-for//g' \
    | sed 's/-Individual-Retirement-Arrangements-/-/g' \
    | sed 's/-For-Individuals/-/g' \
    | sed 's/-for-Individuals/-/g' \
    | sed 's/-Return-of-//g' \
    | sed 's/-Including-Rental-of-/-plus-/g' \
    | sed 's/-Income-Return-for-//g' \
    | sed 's/-Other-Dispositions-/-/g' \
    | sed 's/-Losses//g' \
    | sed 's/Application/App/g' \
    | sed 's/-Guide-for-//g' \
    | sed 's/-Other-TaxFavored-Health-Plans//g' \
    | sed 's/-Other-Information-for-Members-of-the-Clergy-/-/g' \
    | sed -r 's/-\{2,8}/-/g' \
    | sed 's/-$//g'
    )
    

  # Append table row to content (without '|')
  content+="$filename-$subject.pdf\n"
done

# Write the final content to the markdown file
echo -e "$content" > "$output_file"
echo "Fini"
