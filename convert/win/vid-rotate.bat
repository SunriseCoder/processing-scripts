Rem Usage: vid-rotate <filename> <transpose>
Rem <transpose>:
Rem 0 = 90° counter-clockwise and vertical flip (default)
Rem 1 = 90° clockwise
Rem 2 = 90° counter-clockwise
Rem 3 = 90° clockwise and vertical flip

Rem variables
set resource_path_escaped=%CONVERT_HOME:\=\\%\\res
set tmp_file=tmp.txt

set transpose=%2

set video_tmp_name=%~n1_tmp.mp4
set video_result_name=%~n1_rotated.mp4

Rem Begin
echo ============================================================
echo Processing of video %1 begin

Rem Rotating
echo ==== Rotating
	Rem 1. deint filter is needed to remove interline encoding of the video, otherwise it causes lines on the fast moving objects
	Rem 2. -video_track_timescale 90000 is needed to time_base of the video would match to the Intro and Outro
	Rem    to avoid problems with playback speed and video length glitches
	Rem 3. aac -ar 48000 converts audio track to 48kHz to compatibility with Intro's and Outro's audio tracks
	ffmpeg -y ^
		-i %1 ^
		-map 0:v -map 0:a ^
		-filter_complex "[0]yadif=mode=send_field:deint=interlaced[deint],[deint]transpose=%transpose%" ^
		-c:v libx264 -crf 23 -video_track_timescale 90000 ^
		-c:a copy ^
		"%video_tmp_name%"
	if %errorlevel% neq 0 exit /b %errorlevel%

echo === renaming to logo file ===
	move "%video_tmp_name%" "%video_result_name%"

echo Processing of %1 is done
echo ============================================================

:exit
