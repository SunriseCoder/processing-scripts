#!/bin/bash

if [ $# -lt 1 ]; then
	echo "Usage: vid-dump-timebase.sh <mask>"
	echo "       where <mask> is like: \"*.mp4\""
	exit
fi

for file in $1; do
	tb=`ffprobe -v error -select_streams v:0 -show_entries stream=time_base -of csv=p=0 "$file"`
	echo "$file   [ $tb ]"
done
