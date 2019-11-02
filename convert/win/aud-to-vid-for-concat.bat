Rem %1 = source audio file
Rem %2 = filename of stub image
Rem %3 = audio format (aac, ac3, etc...)
Rem %4 = audio frame rate
Rem %5 = audio channels amount

set source_audio_filename=%1
set target_video_filename=%~n1.mp4

set image_stub_filename=%CONVERT_HOME%\res\pictures\AV-Stub-SPP-640x360.jpg
if NOT "%~2"=="" (
	set image_stub_filename=%CONVERT_HOME%\res\pictures\%2
)

set audio_format=aac
if NOT "%~3"=="" (
	set audio_format=%3
)

if NOT "%~4"=="" (
	set frame_rate= -ar %4 
)

if NOT "%~5"=="" (
	set channel_number= -ac %5 
)

ffmpeg ^
	-loop 1 ^
	-i %image_stub_filename% ^
	-i %source_audio_filename% ^
	-c:a %audio_format% -b:a 64k %frame_rate% %channel_number% ^
	-c:v libx264 -video_track_timescale 90000 -vsync vfr -r 25 ^
		-tune stillimage -pix_fmt yuv420p ^
	-shortest ^
	%1.mp4

echo %1 is done
