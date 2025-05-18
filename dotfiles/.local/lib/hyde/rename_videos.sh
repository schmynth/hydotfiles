#!/bin/bash

# Directory where the video files are located (current directory by default)
VIDEO_DIR="${1:-.}"

# Loop through all video files in the directory
for video_file in "$VIDEO_DIR"/*.{mp4,mkv,avi,flv,webm,mov,MOV}; do
    # Check if the file exists to avoid errors on empty directories
    if [[ -f "$video_file" ]]; then
        # Extract creation date from the video file's metadata using ffmpeg
				creation_date=$(ffmpeg -i "$video_file" 2>&1 | grep -i 'creation_time' | sed -E 's/.*creation_time\s*:\s*(.*)/\1/' | sed '1p;d' )
        # If creation date exists, format it into a safe string for the file name
        if [[ -n "$creation_date" ]]; then
            # Convert the creation date into a usable format: YYYY-MM-DD_HH-MM-SS
            formatted_date=$(echo "$creation_date" | sed -E 's/[-: ]+/_/g' | cut -d'.' -f1)
            
            # Get the file extension
            extension="${video_file##*.}"

            # Generate the new filename
            new_filename="${formatted_date}.${extension}"
			
			# log the changes
			touch log.txt
            echo "Renamed: $video_file -> $new_filename" >> log.txt

            # Rename the file
            mv "$video_file" "$VIDEO_DIR/$new_filename"
            echo "Renamed: $video_file -> $new_filename"
        else
            echo "No creation date found for: $video_file"
        fi
    fi
done

echo "Renaming complete."

