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
  #content+="| [$filename](/ea/pmd/view.$filename) | $subject |\n"
done

