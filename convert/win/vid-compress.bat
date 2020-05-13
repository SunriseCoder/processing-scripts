Rem Compressing video to x264 CRF=23

set compressed_name=%~n1_compressed%~x1

ffmpeg ^
	-i %1 ^
	-c:v libx264 -crf 23 -video_track_timescale 90000 -vsync vfr -r 25 ^
	-c:a aac -vbr 3 ^
	"%compressed_name%"

echo Compressing of %1 is done

call vid-norm-aud.bat "%compressed_name%"
