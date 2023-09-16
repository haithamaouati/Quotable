#!/bin/bash

# Author: Haitham Aouati
# GitHun: github.com/haithamaouati

clear

text="Quotable"
author="by Haitham Aouati"

# Calculate the width of the terminal
term_width=$(tput cols)

# Calculate the length of the text after applying figlet
text_length=$(figlet -f standard "$text" | head -n 1 | wc -c)

# Calculate the padding needed to center the text
padding=$((($term_width - $text_length) / 2))
padding2=$((($term_width - ${#author}) / 2))

# Create the padding by repeating spaces
padding_text=$(printf "%*s" $padding "")
padding_author=$(printf "%*s" $padding2 "")

figlet -f standard "$text" | sed "s/^/$padding_text/" | sed "s/$/$padding_text/"
echo "$padding_author$author$padding_author"

# Define the API URL
API_URL="https://api.quotable.io/random"

# Make a GET request to the API and store the response in a variable
response=$(curl -s "$API_URL")

# Parse the JSON response to extract the quote and author
quote=$(echo "$response" | jq -r '.content')
author=$(echo "$response" | jq -r '.author')

# Check if both quote and author are not empty before printing
if [[ -n "$quote" && -n "$author" ]]; then
  echo "Random Quote:"
  echo "$quote"
  echo "- $author"
else
  echo "Failed to fetch a quote. Please try again later."
fi
