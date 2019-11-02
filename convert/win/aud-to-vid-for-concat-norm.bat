Rem %1 = source audio file
Rem %2 = filename of stub image
Rem %3 = audio format (aac, ac3, etc...)
Rem %4 = audio frame rate
Rem %5 = audio channels amount
Rem %6 = output video filename

echo 1: %1
echo 2: %2
echo 3: %3
echo 4: %4
echo 5: %5
echo 6: %6

set source_audio_filename=%1
set norm_audio_filename=%~n1_norm.wav
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

if NOT "%~6"=="" (
	set target_video_filename=%~n6%~x6
)

echo ==== Normalizing %source_audio_filename%
	call norm.bat %source_audio_filename%
	if %errorlevel% neq 0 exit /b %errorlevel%
echo ==== Normalization of %source_audio_filename% is done

echo ==== Converting %source_audio_filename% to Video
ffmpeg ^
	-loop 1 ^
	-i "%image_stub_filename%" ^
	-i "%norm_audio_filename%" ^
	-c:a %audio_format% -b:a 64k %frame_rate% %channel_number% ^
	-c:v libx264 -video_track_timescale 90000 -vsync vfr -r 25 ^
		-tune stillimage -pix_fmt yuv420p ^
	-shortest ^
	"%target_video_filename%"

echo ==== deleting temporary files
	if NOT "%no_delete%"=="1" (
		del "%norm_audio_filename%"
	)

echo ==== deleting of temporary files is done

echo %1 is done
