#!/bin/bash -x

for file in *; do
	echo - Executing command for file $file

	# Directory -> skipping
	if [ -d "$file" ]; then
		echo - - $file is a directory, skipping
	# Script file -> skipping
	elif [[ $file == *".bat" ]] || [[ $file == *".sh" ]]; then
		echo - - $file is a script file, skipping
	# Wave file -> process as audio file
	elif [[ ${file,,} == *".wav" ]]; then
		echo - - $file is an audio file, processing
		./aud-to-vid-for-concat-for-panasonic-v770.sh "$file" "$file.mp4"
		if ! [ $? -eq 0 ]; then
			echo exit $?
		fi
		cp "$file.mp4" concat-branded-videos
	# MTS/MP4/MOV file -> process as video file
	elif [[ ${file,,} == *".mts" ]] || [[ ${file,,} == *".mp4" ]] || [[ ${file,,} == *".mov" ]]; then
		echo - - $file is a video file, processing
		vid-brand-v2-only-logo.bat "$file" 0 0 32000 2 no-silent "$file.mp4"
		if ! [ $? -eq 0 ]; then
			echo exit $?
		fi
		cp "$file.mp4" concat-branded-videos
	# JPG/PNG/BMP file -> process as image file
	elif [[ ${file,,} == *".jpg" ]] || [[ ${file,,} == *".png" ]] || [[ ${file,,} == *".bmp" ]]; then
		echo - - $file is an image file, processing
		img-to-vid.bat "$file" 1920 1080 48000 2 5 "$file.mp4"
		if ! [ $? -eq 0 ]; then
			echo exit $?
		fi
		cp "$file.mp4" concat-branded-videos
	else
		echo - - Could not find suitable processor for $file "($0)"
		exit -1
	fi

done

cd concat-branded-videos
vid-concat.bat

# Cleanup
# mv 2019-* ../../old-concat-branded
# rm files.txt

cp concat.mp4 ../concat.mp4
