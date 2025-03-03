#!/bin/bash

output_file="1.pdf_subject.txt"
touch "$output_file"

# Find all PDF files in the current directory
pdf_files=$(find . -maxdepth 1 -type f -name "*.pdf")

content=""

for pdf_file in $pdf_files; do
  # Extract filename without extension
  filename="${pdf_file##*/}"
  filename="${filename%.*}"

  # Get subject using pdfinfo (may need adjustment for non-IRS PDFs)
  subject=$(pdfinfo "$pdf_file" | grep "Subject: " | cut -d ':' -f 2-)

  # Clean subject: lowercase, remove double spaces, apply substitutions
  subject=$(echo "$subject" | tr '[:upper:]' '[:lower:]' | sed 's/  */ /g' \
    | sed 's/application/App/g' \
    | sed 's/u\.s\. return of //g' \
    | sed 's/u\.s\. //g' \
    | sed 's/instructions for //g' \
    | sed 's/, (for individuals)//g' \
    | sed 's/, (for individuals who use schedule c)//g' \
    | sed 's/s and other dispositions / /g' \
    | sed 's/, for individuals//g' \
    | sed 's/ u\.s\. income tax return for / /g' \
    | sed 's/ and other tax-favored health plans//g' \
    | tr -d '\r'
  )

  # Remove punctuation and replace with hyphens
  subject=$(echo "$subject" | sed 's/[[:punct:]]/-/g')

  # Separate words with hyphens
  subject=$(echo "$subject" | tr ' ' '-')

  # Append table row to content (without '|')
  content+="$filename $subject\n"
done

# Write the final content to the markdown file
echo -e "$content" > "$output_file"
echo "Fini"
