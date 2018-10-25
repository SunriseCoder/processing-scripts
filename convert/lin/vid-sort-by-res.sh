#!/bin/bash

if [ $# -lt 1 ]; then
	echo "Usage: vid-sort-by-res.sh <mask>"
	echo "       where <mask> is like: \"*.mp4\""
	exit
fi

for file in $1; do
	w=`ffprobe -v error -select_streams v:0 -show_entries stream=width -of csv=p=0 "$file"`
	h=`ffprobe -v error -select_streams v:0 -show_entries stream=height -of csv=p=0 "$file"`
	res=$w"x"$h
	echo "$file   [ $w x $h ]"
	
	if [ ! -d $res ]; then
		mkdir $res
	fi
	
	mv "$file" $res/
done
