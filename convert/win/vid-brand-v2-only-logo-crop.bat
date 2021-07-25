Rem Usage: vid-brand-v2-only-logo <filename> <resolution_x> <resolution_y> <crop_offset_x> <crop_offset_y> <audio_frame_rate> <audio_channels> [output_file]
Rem - resolution like 1920 1080, use 0 0 if You don't want to specify resolution

Rem You can set environment variable no_delete=1 to don't delete temporary files

Rem variables
set resource_path_escaped=%CONVERT_HOME:\=\\%\\res
set tmp_file=tmp.txt

set desired_resolution_x=%2
set desired_resolution_y=%3
set desired_resolution=%2x%3

set crop_offset_x=%4
set crop_offset_y=%5

set audio_frame_rate=%6
set audio_channels=%7

set silent_suffix=
if "%6"=="silent" set silent_suffix=silent

set wave_name=%~n1.wav
set file_ext=%~x1
set norm_wave_name=%~n1_norm.wav

set video_tmp_name=%~n1_tmp.mp4
set video_with_logo_name=%~n1_logo.mp4

if not "%~8"=="" (
	set video_with_logo_name=%~n8%~x8
)

del %tmp_file%

Rem getting source file resolution
	ffprobe -v error -select_streams v:0 -show_entries stream=width -of csv=p=0 %1 > %tmp_file%
	set /p source_video_width=<%tmp_file%

	ffprobe -v error -select_streams v:0 -show_entries stream=height -of csv=p=0 %1 > %tmp_file%
	set /p source_video_height=<%tmp_file%

Rem calculating scale and crop filters
	set /A scale_factor_x=%desired_resolution_x%/%source_video_width%
	set /A scale_factor_y=%desired_resolution_y%/%source_video_height%
	if %scale_factor_x% gtr %scale_factor_y% (
		set scale_filter=w=%desired_resolution_x%:h=ih*%desired_resolution_x%/%source_video_width%
	) else (
		set scale_filter=w=iw*%desired_resolution_y%/%source_video_height%:h=%desired_resolution_y%
	)

	set crop_filter=w=%desired_resolution_x%:h=%desired_resolution_y%:x=%crop_offset_x%:y=%crop_offset_y%

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

set logo_name=%CONVERT_HOME%\res\pictures\CA_Logo_for_%desired_resolution%.png

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
		ffmpeg -y -i %1 -vn -ac %audio_channels% "%wave_name%"
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
	ffmpeg -y ^
		-i %1 -i "%norm_wave_name%" -i "%logo_name%" ^
		-map 0:v -map 1:a ^
		-filter_complex "[0]yadif=mode=send_field:deint=interlaced[deint], [deint]scale=%scale_filter%[scaled], [scaled]crop=%crop_filter%[cropped], [cropped][2]overlay=0:0" ^
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
