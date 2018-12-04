Rem 1. Extracting Audio
Rem 2. Normalizing Wav-file
Rem 3. Create new video file with normalized track

set wave_name=%1.wav

ffmpeg -i %1 -vn -ac 2 %wave_name%
echo Unpacking of %wave_name% is done

call norm-stereo.bat %wave_name%
echo Normalization of %wave_name% is done

ffmpeg ^
	-i %1 ^
	-i %wave_name%_norm.wav ^
	-map 0:v ^
	-map 1:0 ^
	-c:v copy ^
	-c:a aac ^
	%1_norm.mp4
echo Replacing audio for %1 is done

echo deleting temporary files

del %wave_name%
del %wave_name%_norm.wav

echo Normalization of audio track for %1 is done
