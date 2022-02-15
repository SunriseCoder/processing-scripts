Rem Compressing video to x264 CRF=23

set compressed_name=%~n1_preview.mp4
set scale_filter=-1:360

ffmpeg ^
	-i %1 ^
	-filter_complex "[0]yadif=mode=send_field:deint=interlaced[deint], [deint]scale=%scale_filter%" ^
	-c:v libx264 -crf 23 -video_track_timescale 90000 -vsync vfr -r 25 ^
	-c:a aac -ac 2 -vbr 3 ^
	"%compressed_name%"

echo Compressing of %1 is done

Rem call vid-norm-aud.bat "%compressed_name%"
