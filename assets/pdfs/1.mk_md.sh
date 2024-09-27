#!/bin/bash

# This makes a .md file in dir=output_dir

# Output dir
output_dir="/home/mcc/websites/ea/_pages/"

# Create the markdown file in the output directory
markdown_file="$output_dir/view.$filename_no_ext.md"
touch "$markdown_file"
