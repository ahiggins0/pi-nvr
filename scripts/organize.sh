#!/bin/bash

# Directory containing the .mp4 files
dir="/mnt/usb/frontdoor"

# Check if the directory exists
if [ ! -d "$dir" ]; then
    echo "Directory $dir does not exist."
    exit 1
fi

# Get the current timestamp
now=$(date +%s)

# Loop through each .mp4 file in the directory
for file in "$dir"/*.mp4; do
    # Check if the file is older than 1 hour
    last_modified=$(stat -c %Y "$file")
    age=$((now - last_modified))
    if [ $age -gt 3600 ]; then
        # Get the last modified date of the file in MM-DD-YYYY format
        modified_date=$(date -d @"$last_modified" +%m-%d-%Y)

        # Create the directory if it doesn't exist
        mkdir -p "$dir/$modified_date"

        # Move the file to the corresponding directory
        mv "$file" "$dir/$modified_date"
        echo "Moved $file to $dir/$modified_date"
    else
        echo "Skipping $file as it's modified within the last hour."
    fi
done
