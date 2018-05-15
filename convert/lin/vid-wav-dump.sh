#!/bin/bash

# Use <image_file_name> as second parameter to append to an existing image

echo Creating audio dump for video "$1"

wav_name="$1.wav"
png_name="$1.png"

if [ -f "$png_name" ]; then
	echo File $png_name exists, exiting
	exit 0
fi

# Extracting wav from video
ffmpeg -i "$1" "$wav_name"

# Creating wav dump as image (Meanings only)
wav-dump.sh "$wav_name" "$png_name" "m"

# Adding image to result HTML-Page
if [ ! -z "$2" ]; then
	echo "<img src=\"$png_name\" /><br />" >> "$2"
fi

# Deleting temporary wav
rm "$wav_name"

echo Audio dump for "$1" is done
