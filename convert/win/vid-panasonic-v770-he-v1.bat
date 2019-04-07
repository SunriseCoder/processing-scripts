Rem Usage: vid-panasonic-v770-he-v1 <filename> [silent]

Rem variables
set resource_path_escaped=%CONVERT_HOME:\=\\%\\res
set silent_suffix=
if "%2"=="silent" set silent_suffix=-silent

set wave_name=%~n1.wav
set norm_wave_name=%~n1_norm.wav

set video_with_logo_name=%~n1_logo%~x1

set video_tmp_name=%~n1_tmp%~x1
set video_ready_name=%~n1_ready%~x1

Rem Begin
echo ============================================================
echo Processing of video %1 begin

Rem Normalizing Audio
echo ==== Normalizing audio
	echo ==== ==== Unpacking %wave_name%
		ffmpeg -i %1 -vn -ac 2 %wave_name%
	echo ==== ==== Unpacking of %wave_name% is done

	echo ==== ==== Normalizing %wave_name%
		call norm-stereo.bat %wave_name%
echo ==== Normalization of %wave_name% is done

Rem Embedding Logo
echo ==== Embedding Logo
	ffmpeg ^
		-i %1 -i %norm_wave_name% -i %CONVERT_HOME%\res\pictures\CA_Logo_for_1920x1080.png ^
		-map 0:0 -map 1:0 ^
		-filter_complex "[0]yadif=mode=send_field:deint=interlaced[deint], [deint][2]overlay=0:0" ^
		-c:v libx264 -crf 23 -r 25 ^
		-c:a aac ^
		%video_with_logo_name%

Rem Intro and Outro
echo ==== Wrapping Intro and Outro
	Rem Preparing files_.txt

	echo file %resource_path_escaped%\\videos\\panasonic-v770-he\\CA_Intro_1920x1080-25fps%silent_suffix%.MTS > files_.txt
	set file_name_with_quote=%video_with_logo_name%
	set file_name=%file_name_with_quote:"=%
	echo file '%file_name%' >> files_.txt
	echo file %resource_path_escaped%\\videos\\panasonic-v770-he\\CA_Outro_1920x1080-25fps%silent_suffix%.MTS >> files_.txt

	ffmpeg -f concat -safe 0 -i files_.txt -c copy %video_tmp_name%
	
	del files_.txt

	move %video_tmp_name% %video_ready_name%
echo ==== Intro and Outro are done

echo ==== Packing to mp3
	ffmpeg -i %norm_wave_name% -ar 22050 -q:a 9 %~n1.mp3
echo ==== Packing of mp3 is done

echo ==== deleting temporary files
	del %wave_name%
	del %norm_wave_name%
	del %video_with_logo_name%
echo ==== deleting of temporary files is done

echo Processing of %1 is done
echo ============================================================

:exit
