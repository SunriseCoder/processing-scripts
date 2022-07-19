Rem Usage: vid-brand-v3-only-logo <filename> <resolution_x> <resolution_y> <audio_frame_rate> <audio_channels> [silent] [output_file]
Rem - resolution like 1920 1080, use 0 0 if You don't want to specify resolution

Rem You can set environment variable no_delete=1 to don't delete temporary files

Rem variables
set resource_path_escaped=%CONVERT_HOME:\=\\%\\res
set tmp_file=tmp.txt

set desired_width=%2
set desired_height=%3
set desired_resolution=%2x%3

set audio_frame_rate=%4
set audio_channels=%5

set silent_suffix=
if "%6"=="silent" set silent_suffix=silent

set wave_name=%~n1.wav
set file_ext=%~x1
set norm_wave_name=%~n1_norm.wav

set video_tmp_name=%~n1_tmp.mp4
set video_with_logo_name=%~n1_logo.mp4

set scale_filter=-1:-1

if not "%~7"=="" (
	set video_with_logo_name=%~n7%~x7
)

del %tmp_file%

Rem getting source file resolution
	ffprobe -v error -select_streams v:0 -show_entries stream=width -of csv=p=0 %1 > %tmp_file%
	set /p source_video_width=<%tmp_file%

	ffprobe -v error -select_streams v:0 -show_entries stream=height -of csv=p=0 %1 > %tmp_file%
	set /p source_video_height=<%tmp_file%
	set source_resolution=%source_video_width%x%source_video_height%

set result_resolution=%desired_resolution%

if not "%desired_resolution%" == "0x0" (
	if not "%desired_resolution%" == "%source_resolution%" (
		set scale_filter=%desired_width%:%desired_height%
	)
)

if "%source_resolution%" == "3840x2160" (
	set result_resolution=1920x1080
	set scale_filter=1920:1080
)

Rem getting audio sample rate
	if "%audio_frame_rate%" == "0" (
		ffprobe -v error -select_streams a:0 -show_entries stream=sample_rate -of csv=p=0 %1 > %tmp_file%
		set /p audio_frame_rate=<%tmp_file%
	)

Rem getting audio channel number
	if "%audio_channels%" == "0" (
		ffprobe -v error -select_streams a:0 -show_entries stream=channels -of csv=p=0 %1 > %tmp_file%
		set /p audio_channels=<%tmp_file%
		if %audio_channels% gtr 2 (
			set audio_channels=2
		)
	)

del %tmp_file%

set logo_name=%CONVERT_HOME%\res\pictures\v2\CA_Logo_for_%result_resolution%_watermark_white.png

Rem Checking that Logo exist, otherwise format is not supported

	if not exist %logo_name% (
		echo Format is not supported, because there is no file: %logo_name%
		exit /b -1
	)

Rem Begin
echo ============================================================
echo Processing of video %1 begin

Rem Normalizing Audio
echo ==== Normalizing audio
	echo ==== ==== Unpacking %wave_name%
		ffmpeg -i %1 -vn -ac %audio_channels% "%wave_name%"
		if %errorlevel% neq 0 exit /b %errorlevel%
	echo ==== ==== Unpacking of %wave_name% is done

	echo ==== ==== Normalizing %wave_name%
		call norm.bat "%wave_name%"
		if %errorlevel% neq 0 exit /b %errorlevel%
echo ==== Normalization of %wave_name% is done

Rem Embedding Logo
echo ==== Embedding Logo
	Rem 1. deint filter is needed to remove interline encoding of the video, otherwise it causes lines on the fast moving objects
	Rem 2. -video_track_timescale 90000 is needed to time_base of the video would match to the Intro and Outro
	Rem    to avoid problems with playback speed and video length glitches
	Rem 3. aac -ar 48000 converts audio track to 48kHz to compatibility with Intro's and Outro's audio tracks
	ffmpeg ^
		-i %1 -i "%norm_wave_name%" -loop 1 -i "%logo_name%" ^
		-map 0:v -map 1:a ^
		-filter_complex "[0]yadif=mode=send_field:deint=interlaced[deint], [deint]scale=%scale_filter%[scaled], [scaled][2]overlay=0:0:shortest=1" ^
		-c:v libx264 -crf 23 -video_track_timescale 90000 -vsync vfr -r 25 ^
		-c:a aac -ar %audio_frame_rate% -ac %audio_channels% -vbr 3 ^
		"%video_tmp_name%"
	if %errorlevel% neq 0 exit /b %errorlevel%

echo ==== deleting temporary files
	if NOT "%no_delete%"=="1" (
		del files_.txt
		del "%wave_name%"
		del "%norm_wave_name%"
	)

echo ==== deleting of temporary files is done

echo === renaming to logo file ===
	move "%video_tmp_name%" "%video_with_logo_name%"

echo Processing of %1 is done
echo ============================================================

:exit
