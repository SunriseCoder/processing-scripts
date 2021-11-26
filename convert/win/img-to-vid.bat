Rem Usage: img-to-vid <filename> <resolution_x> <resolution_y> <audio_frame_rate> <audio_channels> <duration> <output_file>
Rem - resolution like 1920 1080, use 0 0 if You don't want to specify resolution

Rem You can set environment variable no_delete=1 to don't delete temporary files

Rem variables
set resource_path_escaped=%CONVERT_HOME:\=\\%\\res

set source_file=%1
set desired_resolution=%2x%3

set audio_frame_rate=%4
set audio_channels=%5

set video_duration=%6
set output_file=%7


set scale_filter=-1:-1
if "%desired_resolution%" neq "0x0" (
	set scale_filter=%2:%3
)

ffmpeg ^
	-loop 1 -i "%source_file%" -f lavfi -i anullsrc=r=%audio_frame_rate%:cl=%audio_channels% ^
	-filter_complex "[0]scale=%scale_filter%" ^
	-c:v libx264 -t %video_duration% -crf 23  -video_track_timescale 90000 -vsync vfr -r 25 -pix_fmt yuv420p ^
	-c:a aac -ar %audio_frame_rate% -ac %audio_channels% -vbr 3 ^
	"%output_file%"

rem	-f lavfi -i anullsrc=r=%audio_frame_rate%:cl=mono ^
