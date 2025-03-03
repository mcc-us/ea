#!/bin/bash

# Directory containing the PDF files
DIRECTORY="."  # Change this to the actual directory if needed

# Function to convert a string to title case
title_case() {
  local str="$1"
  local result=""
  local first_char=1

  for word in $str; do
    if [[ $first_char -eq 1 ]]; then
      result+="${word^}"
      first_char=0
    else
      result+=" ${word,,}"
    fi
  done
  echo "$result"
}

# Loop through all PDF files in the directory
for file in "$DIRECTORY"/*.pdf; do
  if [[ -f "$file" ]]; then
    # Extract the filename without the extension
    filename=$(basename "$file" .pdf)

    # Extract the Subject from pdfinfo
    subject=$(pdfinfo "$file" | grep "Subject:" | cut -d ':' -f 2- | tr -d '[:space:]')

    # Check if the subject was found
    if [[ -n "$subject" ]]; then
      # 1. Translate the subject to title case
      title_subject=$(title_case "$subject")

      # 2. Remove any non-alphanumeric characters
      cleaned_subject=$(echo "$title_subject" | sed 's/[^[:alnum:][:space:]]//g')

      # 3. Remove double spaces
      cleaned_subject=$(echo "$cleaned_subject" | sed 's/  */ /g')

      # 4. Substitute single spaces between words to '-'
      cleaned_subject=$(echo "$cleaned_subject" | tr ' ' '-')

      # Construct the new filename
      new_filename="${filename}-${cleaned_subject}.pdf"

      # Rename the file
      mv "$file" "$DIRECTORY/$new_filename"

      echo "Renamed '$file' to '$DIRECTORY/$new_filename'"
    else
      echo "No subject found for '$file'"
    fi
  else
    echo "File '$file' not found."
  fi
done

echo "Finished renaming PDF files."
