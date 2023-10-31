#!/bin/bash

output_dir="./results"

# Check for the correct number of command line arguments
if [ "$#" -ne 2 ]; then
    printf "Usage: $0 <input_tsv_file> <input_text_file>\n"
    exit 1
fi

# Assign the input files to variables
tsv_file="$1"
text_file="$2"

# Check if the input files exist
if [ ! -f "$tsv_file" ]; then
    printf "Input TSV file '$tsv_file' does not exist.\n"
    exit 1
fi

if [ ! -f "$text_file" ]; then
    printf "Input text file '$text_file' does not exist.\n"
    exit 1
fi

# Read the strings from the text file into an array
mapfile -t strings < "$text_file"

# Get the total number of strings
total_strings=${#strings[@]}

# Create a file to store non-matching strings
non_matching_file="$output_dir/non_matching.txt"
rm -f "$non_matching_file"
non_matchings=()

start_time=$(date +%s)

# Process each string from the array
cnt=1
for string in "${strings[@]}"; do
    string=$(echo "$string" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')  # Remove spaces from the string
    output_file="$output_dir/${string}.txt"
    printf "→ Search for [$string] ($cnt / $total_strings)\r"

    # Use grep -ai to search for the string in the TSV file
    # If a match is found, append the result to the output file
    # If no match is found, append the string to the non_matching_file
    # grep -qai "A0A024R1R8" AlphaMissense_aa_substitutions.tsv > ./results/A0A024R1R8.txt
    if grep -ai "$string" "$tsv_file" > "$output_file"; then
        :
    else
        non_matchings+=("$string")
        rm -f "$output_file"
    fi
    ((cnt++))
done

end_time=$(date +%s)
total_time=$((end_time - start_time))
# echo "Total time taken: $total_time seconds"

hours=$((total_time / 3600))
total_time=$((total_time % 3600))
minutes=$((total_time / 60))
seconds=$((total_time % 60))

formatted_time=$(printf "%02dh %02dm %02ds" "$hours" "$minutes" "$seconds")

printf "\n"
# mapfile -t non_matchings < "$non_matching_file"
for non_mat in "${non_matchings[@]}"; do
    echo "$non_mat" >> "$non_matching_file"
done
# printf $non_matchings

echo "Processing completed ($formatted_time)"
