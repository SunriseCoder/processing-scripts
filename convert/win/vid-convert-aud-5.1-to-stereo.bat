Rem Usage: vid-convert-aud-5.1-to-stereo.bat <filename>

Rem variables
set resource_path_escaped=%CONVERT_HOME:\=\\%\\res

set video_tmp_name=%~n1_tmp.mp4
set video_ready_name=%~n1_stereo.mp4

ffmpeg ^
	-i %1 ^
	-filter_complex "[0:a]pan=stereo|c0<FL+FC|c1<FR+FC[a]" ^
	-map 0:v -map "[a]" ^
	-c:v copy ^
	-c:a aac -ar 48000 -ac 2 -vbr 3 ^
	"%video_tmp_name%"

if %errorlevel% neq 0 goto error /b %errorlevel%

move "%video_tmp_name%" "%video_ready_name%"

if %errorlevel% neq 0 goto error /b %errorlevel%

echo Processing of %1 is done
echo ============================================================

:success
echo === Completed successfully ===
goto end

:error
echo === Completed with Errors!!! ===
goto end

:end
