Rem Usage: vid-aud-to-stereo <filename>

Rem You can set environment variable no_delete=1 to don't delete temporary files

Rem variables

set wave_name=%~n1.wav
set file_ext=%~x1

set video_ready_name=%~n1_stereo%file_ext%

Rem Begin
echo ============================================================
echo Processing of video %1 begin

Rem Unpacking Audio
echo ==== Unpacking audio
	echo ==== ==== Unpacking %wave_name%
		ffmpeg -i %1 -vn -ac 2 "%wave_name%"
		if %errorlevel% neq 0 exit /b %errorlevel%
	echo ==== ==== Unpacking of %wave_name% is done
echo ==== Unpacking of %wave_name% is done

Rem Replacing audio
echo ==== Replacing audio
	Rem 1. aac -ar 48000 converts audio track to 48kHz to compatibility with Intro's and Outro's audio tracks
	ffmpeg ^
		-i %1 -i "%wave_name%" ^
		-map 0:v -map 1:0 ^
		-c:v copy ^
		-c:a aac -ar 48000 ^
		"%video_ready_name%"
	if %errorlevel% neq 0 exit /b %errorlevel%

Rem deleting temporary files
echo ==== deleting temporary files
	if NOT "%no_delete%"=="1" (
		del "%wave_name%"
	)
echo ==== deleting of temporary files is done

echo Processing of %1 is done
echo ============================================================

:exit
