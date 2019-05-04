Rem 1. Extracting Audio
Rem 2. Normalizing Wav-file
Rem 3. Create new video file with normalized track

set wave_name=%~n1.wav
set norm_wave_name=%~n1_norm.wav
set norm_video_name=%~n1_norm%~x1

ffmpeg -i %1 -vn -ac 2 %wave_name%
echo Unpacking of %wave_name% is done

call norm-stereo.bat %wave_name%
echo Normalization of %wave_name% is done

ffmpeg ^
	-i %1 ^
	-i %norm_wave_name% ^
	-map 0:v ^
	-map 1:0 ^
	-c:v copy ^
	-c:a aac ^
	%norm_video_name%
echo Replacing audio for %1 is done

echo deleting temporary files

del %wave_name%
del %norm_wave_name%

echo Normalization of audio track for %1 is done
