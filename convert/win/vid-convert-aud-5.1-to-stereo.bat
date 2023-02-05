Rem Usage: vid-convert-aud-5.1-to-stereo.bat <filename>

Rem variables
set resource_path_escaped=%CONVERT_HOME:\=\\%\\res
set tmp_file=tmp.txt
set silent_suffix=
if "%2"=="silent" set silent_suffix=silent

set wave_name=%~n1.wav
set file_ext=%~x1
set norm_wave_name=%~n1_norm.wav

set video_with_logo_name=%~n1_logo.mp4

set video_tmp_name=%~n1_tmp.mp4
set video_ready_name=%~n1_ready.mp4

del %tmp_file%

ffmpeg ^
	-i %1 ^
	-filter_complex "[0:a]pan=stereo|c0<FL+FC|c1<FR+FC[a]" ^
	-map 0:v -map "[a]" ^
	-c:v copy ^
	-c:a aac -ar 48000 -ac 2 -vbr 3 ^
	"%video_tmp_name%"

if %errorlevel% neq 0 exit /b %errorlevel%

move "%video_tmp_name%" "%video_ready_name%"

if %errorlevel% neq 0 exit /b %errorlevel%

echo Processing of %1 is done
echo ============================================================

:exit
echo Completed successfully
pause
exit

:error
echo Completed with Errors!!!
pause
exit
