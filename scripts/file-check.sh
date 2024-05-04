#!/bin/bash

# Directory path
dir="/mnt/usb/frontdoor"

# Check for mp4 files less than 2 bytes
files=$(find "$dir" -maxdepth 1 -type f -name "*.mp4" -size -2c)

if [ -n "$files" ]; then
    # Loop through each file
    while IFS= read -r file; do
        # Delete the file
        rm "$file"
    done <<< "$files"

    # Restart the service
    systemctl restart frontdoor-cam
fi
