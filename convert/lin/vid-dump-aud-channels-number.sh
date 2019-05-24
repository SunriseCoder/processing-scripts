#!/bin/bash

if [ $# -lt 1 ]; then
	echo "Usage: vid-dump-res.sh <mask>"
	echo "       where <mask> is like: \"*.mp4\""
	exit
fi

for file in $1; do
	channels=`ffprobe -v error -select_streams a:0 -show_entries stream=channels -of csv=p=0 "$file"`
	echo "$file   [$channels]"
done
