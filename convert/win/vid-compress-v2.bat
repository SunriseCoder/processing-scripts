Rem Compressing video to x264 CRF=23

set tmp_name=%~n1_compressed-tmp%~x1
set out_name=%~n1_compressed%~x1

ffmpeg ^
	-i %1 ^
	-c:v libx264 -crf 23 -video_track_timescale 90000 ^
	-c:a aac -vbr 3 ^
	"%tmp_name%"

move "%tmp_name%" "%out_name%"

echo Compressing of %1 is done
