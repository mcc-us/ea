#!/bin/bash

# Directory containing PDF files
directory="."  # Change this to the desired directory if needed

# Output file for subjects
output_file="11.PDF.subjects.txt"

# Clear the output file if it exists
> "$output_file"

# Find all PDF files in the specified directory
find "$directory" -type f -name "*.pdf" -print0 | while IFS= read -r -d $'\0' file; do
  # Extract the filename without the path
  filename=$(basename "$file")

  # Extract the Subject using pdfinfo
  subject=$(pdfinfo "$file" 2>/dev/null | grep "Subject:" | cut -d ':' -f 2- )
  
  # Clean Subject
  subject=$(echo "$subject" \
    | tr '[:punct:]' ' ' \
    | sed 's/ and / /g' \
    | sed 's/US//g' \
    | sed 's/ IRS / /g' \
    | sed 's/ s /s /g' \
    | sed 's/ etc//g' \
    | sed 's/ or //g' \
    | sed 's/ Instructions for//g' \
    | sed 's/ Individual Retirement Arrangements / /g' \
    | sed 's/Individuals/ /g' \
    | sed 's/ for / /g' \
    | sed 's/ For / /g' \
    | sed 's/ Return of //g' \
    | sed 's/ Including Rental of / plus /g' \
    | sed 's/Including Use by Daycare Providers//g' \
    | sed 's/ Income Return for //g' \
    | sed 's/ Other Dispositions / /g' \
    | sed 's/Form 3115//g' \
    | sed 's/Form 706//g' \
    | sed 's/Form 709//g' \
    | sed 's/Form 8865//g' \
    | sed 's/Form 1041//g' \
    | sed 's/Form 8606//g' \
    | sed 's/Form W 7//g' \
    | sed 's/Form 941//g' \
    | sed 's/Form 56//g' \
    | sed 's/Form 5329//g' \
    | sed 's/Form 1040//g' \
    | sed 's/Form 8995//g' \
    | sed 's/Form 843//g' \
    | sed 's/Form 2848//g' \
    | sed 's/Form 1098//g' \
    | sed 's/Form 6251//g' \
    | sed 's/Form 2555//g' \
    | sed 's/Form 8821//g' \
    | sed 's/Form 1065//g' \
    | sed 's/Form 4684//g' \
    | sed 's/Form 1099 s//g' \
    | sed 's/Form 8938//g' \
    | sed 's/Form 8863//g' \
    | sed 's/Form 8936//g' \
    | sed 's/Form 1098 E//g' \
    | sed 's/Form Forms 1099-MISC 1099-NEC//g' \
    | sed 's/Form 8889//g' \
    | sed 's/Form SS 4//g' \
    | sed 's/Form SS 8//g' \
    | sed 's/Form 172//g' \
    | sed 's/Form 1120//g' \
    | sed 's/Form 3800//g' \
    | sed 's/Form 5405//g' \
    | sed 's/Form 8857//g' \
    | sed 's/Forms 1099 A 1099 C//g' \
    | sed 's/Forms 1099 S//g' \
    | sed 's/TCE //g' \
    | sed 's/Loss //g' \
    | sed 's/Losses//g' \
    | sed 's/Request //g' \
    | sed 's/Miscellaneous //g' \
    | sed 's/For use with//g' \
    | sed 's/Additional//g' \
    | sed 's/Other  Dispositions//g' \
    | sed 's/For   Who Use /Using /g' \
    | sed 's/With Total Assets of   10 Million or More/Assets gt 10MM/g' \
    | sed 's/With Total Assets of  10 Million or More/Assets gt 10MM/g' \
    | sed 's/Under Section 1362 of the Internal Revenue Code//g' \
    | sed 's/Application//g' \
    | sed 's/ Guide for //g' \
    | sed 's/ Other TaxFavored Health Plans//g' \
    | sed 's/ Other Information for Members of the Clergy / /g' \
    | sed 's/United States//g' \
    | sed 's/U S//g' \
    | sed 's/Supplement to Pub  15  Employers Tax Guide//g' \
    | sed 's/Religious Organizations//g' \
    | sed 's/Tax Guide/Guide/g' \
    | sed 's/•//g' \
    | sed 's/of Over  10 000/gt 10k/g' \
    | sed 's/Received in a Trade or Business//g' \
    | sed 's/Rev  December 2024  or later revision//g' \
    | sed -E 's/Use with the August 2019 revision of//g' \
    | sed -E 's/ +/-/g' \
    | sed -E 's/--/-/g' \
    | tr -d ' ' \
    | sed -E 's/-$//' \
    | sed 's/–//g' \
    )

#    | sed  -r 's/-\{2,8}/-/g' \ Supplement to Pub  15  Employers Tax Guide
#    | sed 's/-$//g'
#    | tr -d '\r' \
#    | tr ' ' '-' \
#    | sed 's/ Tax / /g' \

  # Append the File Name & Subject to the output file
  filename_no_ext="${filename%.pdf}"
  if [[ -n "$subject" ]]; then
    echo "$filename_no_ext-$subject.pdf" >> "$output_file"
  fi
done

echo "FINI"
