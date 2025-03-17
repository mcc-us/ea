#!/bin/bash

# Create or clear the output file
> 1.names.txt

# Loop through all PDF files in the current directory
for pdf in *.pdf; do
    # Extract filename without extension
    file="${pdf%.pdf}"

    # Extract the Subject field from the PDF metadata
    subject=$(pdfinfo "$pdf" | awk -F': ' '/Subject/ {print $2}')

    # Clean up the subject:
    # - Convert to lowercase
    # - Replace "vita/tce" with "vita"
    # - Replace all spaces (single or multiple) with "."
    # - Replace "/" with "."
    # - Remove "u.s."
    # - Remove commas
    subject=$(echo "$subject" | \
    tr '[:upper:]' '[:lower:]' | \
    sed -E 's/vita\/tce/vita/g' | \
    tr -s ' ' '.' | \
    tr '/' '.' | \
    sed 's/u.s.//g' | \
    tr -d '\' |\
    tr -d ',')

    # Concatenate filename with cleaned subject and ".pdf"
    echo "$file.$subject.pdf" >> 1.names.txt
done

