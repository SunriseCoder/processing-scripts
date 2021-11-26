#!/bin/bash -x

echo Parsing folder name to get target video parameters

folder=`pwd`;
folder=${folder##*/}
folder=${folder##*concat-}

video_width=${folder%%x*};
folder=${folder#*x}
echo video_width is: $video_width
echo folder is: $folder

video_height=${folder%%-*};
folder=${folder#*-}
echo video_height is: $video_height
echo folder is: $folder

audio_frame_rate=${folder%%-*};
folder=${folder#*-}
echo audio_frame_rate is: $audio_frame_rate
echo folder is: $folder

audio_channel_number=${folder%%-*};
folder=${folder#*-}
echo audio_channel_number is: $audio_channel_number
echo folder is: $folder

silent_mode=${folder%%-*};
folder=${folder#*-}
echo silent_mode is: $silent_mode
echo folder is: $folder

#video_width=1920;
#video_height=1080;
#audio_frame_rate=48000;
#audio_channel_number=2;
#silent_mode="no-silent";

echo File list:
for file in *; do
	echo - Found file: $file
done

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
		
		# Looking for a video thumbnail image

			# Sri Prem Prayojan
			if [[ $file == *"SPP"* ]]; then
				thumbnail="AV-Stub-SPP-${video_width}x${video_height}.jpg";
			# Sri Achyuta Lal Bhatta Goswami Maharaja
			elif [[ $file == *"SALBGM"* ]]; then
				thumbnail="AV-Stub-SALBGM-${video_width}x${video_height}.jpg"
			else
				echo Unknown Author of the class
				exit -1
			fi

		aud-to-vid-for-concat-norm.bat "$file" "$thumbnail" aac $audio_frame_rate $audio_channel_number "$file.mp4"

		if ! [ $? -eq 0 ]; then
			echo exit $?
		fi
		cp "$file.mp4" concat-branded-videos
	# MTS/MP4/MOV file -> process as video file
	elif [[ ${file,,} == *".mts" ]] || [[ ${file,,} == *".mp4" ]] || [[ ${file,,} == *".mov" ]]; then
		echo - - $file is a video file, processing
		vid-brand-v2-only-logo.bat "$file" $video_width $video_height $audio_frame_rate $audio_channel_number $silent_mode "$file.mp4"
		if ! [ $? -eq 0 ]; then
			echo exit $?
		fi
		cp "$file.mp4" concat-branded-videos
	# JPG/PNG/BMP file -> process as image file
	elif [[ ${file,,} == *".jpg" ]] || [[ ${file,,} == *".png" ]] || [[ ${file,,} == *".bmp" ]]; then
		echo - - $file is an image file, processing
		img-to-vid.bat "$file" $video_width $video_height $audio_frame_rate $audio_channel_number 5 "$file.mp4"
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
# mv 20* ../../old-concat-branded
# rm files.txt
# rm joints.txt
