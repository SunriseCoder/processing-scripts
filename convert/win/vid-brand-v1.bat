Rem Usage: vid-brand-v1 <filename> [silent]

Rem You can set environment variable no_delete=1 to don't delete temporary files

Rem variables
set resource_path_escaped=%CONVERT_HOME:\=\\%\\res
set silent_suffix=
if "%2"=="silent" set silent_suffix=-silent

set wave_name=%~n1.wav
set file_ext=%~x1
set norm_wave_name=%~n1_norm.wav

set video_with_logo_name=%~n1_logo%~x1

set video_tmp_name=%~n1_tmp%~x1
set video_ready_name=%~n1_ready.mp4

Rem getting source file resolution
	del res_tmp.txt

	ffprobe -v error -select_streams v:0 -show_entries stream=width -of csv=p=0 %1 > res_tmp.txt
	set /p w=<res_tmp.txt

	ffprobe -v error -select_streams v:0 -show_entries stream=height -of csv=p=0 %1 > res_tmp.txt
	set /p h=<res_tmp.txt
	del res_tmp.txt
	set resolution=%w%x%h%

set intro_name=%resource_path_escaped%\\videos\\CA_Intro_%resolution%-25fps%silent_suffix%%file_ext%
set outro_name=%resource_path_escaped%\\videos\\CA_Outro_%resolution%-25fps%silent_suffix%%file_ext%
set logo_name=%CONVERT_HOME%\res\pictures\CA_Logo_for_%resolution%.png

Rem Checking that Intro and Outro exist, otherwise format is not supported
	if not exist %intro_name% (
		echo Format is not supported, because there is no file: %intro_name%
		exit /b -1
	)

	if not exist %outro_name% (
		echo Format is not supported, because there is no file: %outro_name%
		exit /b -1
	)

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
		ffmpeg -i %1 -vn -ac 2 "%wave_name%"
		if %errorlevel% neq 0 exit /b %errorlevel%
	echo ==== ==== Unpacking of %wave_name% is done

	echo ==== ==== Normalizing %wave_name%
		call norm-stereo.bat "%wave_name%"
		if %errorlevel% neq 0 exit /b %errorlevel%
echo ==== Normalization of %wave_name% is done

Rem Embedding Logo
echo ==== Embedding Logo
	Rem 1. deint filter is needed to remove interline encoding of the video, otherwise it causes lines on the fast moving objects
	Rem 2. -video_track_timescale 90000 is needed to time_base of the video would match to the Intro and Outro
	Rem    to avoid problems with playback speed and video length glitches
	Rem 3. aac -ar 48000 converts audio track to 48kHz to compatibility with Intro's and Outro's audio tracks
	ffmpeg ^
		-i %1 -i "%norm_wave_name%" -i "%logo_name%" ^
		-map 0:v -map 1:0 ^
		-filter_complex "[0]yadif=mode=send_field:deint=interlaced[deint], [deint][2]overlay=0:0" ^
		-c:v libx264 -crf 23 -video_track_timescale 90000 -vsync vfr -r 25 ^
		-c:a aac -ar 48000 ^
		"%video_with_logo_name%"
	if %errorlevel% neq 0 exit /b %errorlevel%
Rem Intro and Outro
echo ==== Wrapping Intro and Outro
	Rem Preparing files_.txt
	echo file '%intro_name%' > files_.txt
	set file_name=%video_with_logo_name:"=%
	echo file '%file_name%' >> files_.txt
	echo file '%outro_name%' >> files_.txt

	ffmpeg -f concat -safe 0 -i files_.txt -c copy "%video_tmp_name%"
	if %errorlevel% neq 0 exit /b %errorlevel%
echo ==== Intro and Outro are done

echo ==== Converting to mp4
	if "%~x1"==".mp4" (
		move "%video_tmp_name%" "%video_ready_name%"
	) else (
		ffmpeg -i "%video_tmp_name%" -c copy  "%video_ready_name%"
	)
echo ==== Converting to mp4 done

echo ==== Packing to mp3
	ffmpeg -i "%norm_wave_name%" -ar 22050 -q:a 9 "%~n1.mp3"
	if %errorlevel% neq 0 exit /b %errorlevel%
echo ==== Packing of mp3 is done

echo ==== deleting temporary files

	if NOT "%no_delete%"=="1" (
		del files_.txt
		del "%wave_name%"
		del "%norm_wave_name%"
		del "%video_with_logo_name%"
		del "%video_tmp_name%"
	)

echo ==== deleting of temporary files is done

echo Processing of %1 is done
echo ============================================================

:exit
