Rem Compressing video to x264 CRF=23

set tmp_name=%~n1_720p-tmp%~x1
set out_name=%~n1_720p%~x1

ffmpeg ^
	-i %1 ^
	-vf scale=-1:720 ^
	-c:v libx264 -crf 23 -video_track_timescale 90000 ^
	-c:a aac -vbr 3 ^
	"%tmp_name%"

move %tmp_name% %out_name%

echo Compressing of %1 is done
