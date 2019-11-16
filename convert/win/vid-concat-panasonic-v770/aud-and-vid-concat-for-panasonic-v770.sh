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
	# MTS file -> process as video file
	elif [[ ${file,,} == *".mts" ]]; then
		echo - - $file is a video file, processing
		vid-brand-v2-only-logo.bat "$file" 1920 1080 no-silent "$file.mp4"
		if ! [ $? -eq 0 ]; then
			echo exit $?
		fi
		cp "$file.mp4" concat-branded-videos
	# MP4 file -> process as video file
	elif [[ ${file,,} == *".mp4" ]]; then
		echo - - $file is a video file, processing
		vid-brand-v2-only-logo.bat "$file" 1920 1080 no-silent "$file.mp4"
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
