#!/bin/bash

if [ $# -lt 1 ]; then
	echo "Usage: vid-dump-timebase.sh <mask>"
	echo "       where <mask> is like: \"*.mp4\""
	exit
fi

for file in $1; do
	tb=`ffprobe -v error -show_streams "$file"`
	echo "=== $file ==="
	echo "$tb"
done
