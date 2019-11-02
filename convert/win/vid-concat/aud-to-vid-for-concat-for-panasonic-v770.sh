#!/bin/bash -x

wav_file=$1
result_file=$2

# Sri Prem Prayojan
if [[ $wav_file == *"SPP"* ]]; then
	thumbnail="AV-Stub-SPP-1920x1080.jpg";
# Sri Achyuta Lal Bhatta Goswami Maharaja
elif [[ $wav_file == *"SALBG"* ]]; then
	thumbnail="AV-Stub-SALBG-1920x1080.jpg"
else
	echo Unknown Author of the class
	exit -1
fi

aud-to-vid-for-concat-norm.bat "$wav_file" "$thumbnail" aac 48000 2 "$result_file"
