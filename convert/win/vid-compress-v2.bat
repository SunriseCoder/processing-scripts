Rem Compressing video to x264 with particular settings
Rem Usage: vid-compress-v2.bat <filename> [crf] [preset]
Rem Where:
Rem     crf - integer from 0 to 56
Rem     preset - word from the list below, for example: veryfast

Rem FFmpeg Presets:
Rem ultrafast superfast veryfast faster fast
Rem medium – default preset
Rem slow slower veryslow
Rem placebo – ignore this as it is not useful

set crf=23
set preset=medium

if NOT "%2" == "" (
	set crf=%2
)

if NOT "%3" == "" (
	set preset=%3
)

echo CRF is: %crf%
echo Preset is: %preset%

set tmp_name=%~n1_compressed_crf-%crf%-%preset%-tmp%~x1
set out_name=%~n1_compressed_crf-%crf%-%preset%%~x1

ffmpeg ^
	-i %1 ^
	-c:v libx264 -preset %preset% -fps_mode cfr -crf %crf% -video_track_timescale 90000 ^
	-c:a aac -q:a 0 ^
	"%tmp_name%"

move "%tmp_name%" "%out_name%"

echo Compressing of %1 is done
