Rem Usage: aud-to-vid-brand-v3-custom-logo-only <filename> <stub> [logo] [silent]

Rem You can set environment variable no_delete=1 to don't delete temporary files

Rem variables
set source_audio_filename=%1
set stub_name=%2
set logo_name=%3
set resource_path_escaped=%CONVERT_HOME:\=\\%\\res
set tmp_file=tmp.txt
set silent_suffix=
if "%4"=="silent" set silent_suffix=silent

set image_stub_filename=%CONVERT_HOME%\res\pictures\AV-Stub-SPP-640x360.jpg
if not "%stub_name%" == "" set image_stub_filename=%stub_name%
if not exist %image_stub_filename% set image_stub_filename=%CONVERT_HOME%\res\pictures\%stub_name%

set image_logo_filename=%CONVERT_HOME%\res\pictures\v2\CA_Logo_for_1920x1080_watermark_white.png
if not "%logo_name%" == "default" set image_logo_filename=%logo_name%
if not exist %image_logo_filename% set image_logo_filename=%CONVERT_HOME%\res\pictures\%logo_name%

set wave_name=%~n1.wav
set file_ext=%~x1
set norm_wave_name=%~n1_norm.wav

set video_tmp_name=%~n1_tmp.mp4
set video_ready_name=%~n1_ready.mp4

del %tmp_file%

Rem getting source file resolution
	ffprobe -v error -select_streams v:0 -show_entries stream=width -of csv=p=0 "%image_stub_filename%" > %tmp_file%
	set /p w=<%tmp_file%

	ffprobe -v error -select_streams v:0 -show_entries stream=height -of csv=p=0 "%image_stub_filename%" > %tmp_file%
	set /p h=<%tmp_file%
	set resolution=%w%x%h%

if "%resolution%" == "3840x2160" (
	set resolution=1920x1080
	set scale_filter=, scale=1920:1080
)

Rem getting audio sample rate
	ffprobe -v error -select_streams a:0 -show_entries stream=sample_rate -of csv=p=0 %1 > %tmp_file%
	set /p frame_rate=<%tmp_file%

Rem getting audio channel number
	ffprobe -v error -select_streams a:0 -show_entries stream=channels -of csv=p=0 %1 > %tmp_file%
	set /p channel_number=<%tmp_file%

del %tmp_file%

Rem Begin
echo ============================================================
echo Processing of video %1 begin

Rem Normalizing Audio
echo ==== Normalizing audio

	echo ==== ==== Normalizing %wave_name%
		call norm.bat "%wave_name%"
		if %errorlevel% neq 0 exit /b %errorlevel%
echo ==== Normalization of %wave_name% is done

Rem Embedding Logo
echo ==== Embedding Logo
	Rem 1. -video_track_timescale 90000 is needed to time_base of the video would match to the Intro and Outro
	Rem    to avoid problems with playback speed and video length glitches
	Rem 2. aac -ar %frame_rate% converts audio track to track with particular frame rate
	Rem    to compatibility with Intro's and Outro's audio tracks
	ffmpeg ^
		-loop 1 ^
		-i "%image_stub_filename%" ^
		-i "%norm_wave_name%" ^
		-i "%image_logo_filename%" ^
		-c:a aac -b:a 64k -ar %frame_rate% -ac %channel_number% ^
		-filter_complex "[0][2]overlay=0:0" ^
		-c:v libx264 -video_track_timescale 90000 -vsync vfr -r 25 ^
			-tune stillimage -pix_fmt yuv420p ^
		-shortest ^
		-fflags +shortest -max_interleave_delta 500M ^
		"%video_tmp_name%"
	if %errorlevel% neq 0 exit /b %errorlevel%

echo ==== Renaming to Ready
	move "%video_tmp_name%" "%video_ready_name%"

echo ==== deleting temporary files

	if NOT "%no_delete%"=="1" (

		del "%norm_wave_name%"
	)

echo ==== deleting of temporary files is done

echo Processing of %1 is done
echo ============================================================

:exit
