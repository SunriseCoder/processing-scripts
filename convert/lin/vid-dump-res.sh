#!/bin/bash

if [ $# -lt 1 ]; then
	echo "Usage: vid-dump-res.sh <mask>"
	echo "       where <mask> is like: \"*.mp4\""
	exit
fi

for file in $1; do
	w=`ffprobe -v error -select_streams v:0 -show_entries stream=width -of csv=p=0 "$file"`
	h=`ffprobe -v error -select_streams v:0 -show_entries stream=height -of csv=p=0 "$file"`
	echo "$file   [ $w x $h ]"
done
