Rem Usage: vid-brand-v2-only-logo-complex <filename>

Rem You can set environment variable no_delete=1 to don't delete temporary files

Rem variables
set resource_path_escaped=%CONVERT_HOME:\=\\%\\res
set tmp_file=tmp.txt

set desired_width=1920
set desired_height=1080
set desired_resolution=%desired_width%x%desired_height%
set result_resolution=%desired_resolution%

set audio_frame_rate=48000
set audio_channels=2

Rem set transpose, scale, crop and pad here
set transpose_filter=1
set scale_factor=1
set scale_filter=iw*%scale_factor%:ih*%scale_factor%
set crop_filter=w=1080:h=1080:x=0:y=300
set pad_filter=w=1920:h=1080:x=420:y=0:color=black

set wave_name=%~n1.wav
set file_ext=%~x1
set norm_wave_name=%~n1_norm.wav

set video_tmp_name=%~n1_tmp.mp4
set video_with_logo_name=%~n1_logo.mp4

set logo_name=%CONVERT_HOME%\res\pictures\CA_Logo_for_%result_resolution%.png

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
		-filter_complex "[0]yadif=mode=send_field:deint=interlaced[deint], [deint]transpose=%transpose_filter%[transposed], [transposed]scale=%scale_filter%[scaled], [scaled]crop=%crop_filter%[cropped], [cropped]pad=%pad_filter%[padded], [padded][2]overlay=0:0:shortest=1" ^
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
