Rem 1. Extracting Audio
Rem 2. Normalizing Wav-file
Rem 3. Create new video file with normalized track

Rem Usage: vid-norm-aud.bat <input-video-file> [channel-number]

set wave_name=%~n1.wav
set norm_wave_name=%~n1_norm.wav
set norm_video_name=%~n1_norm%~x1

set tmp_file=tmp.txt

Rem Getting audio channel number
ffprobe -v error -select_streams a:0 -show_entries stream=channels -of csv=p=0 %1 > %tmp_file%
set /p source_channel_number=<%tmp_file%
echo source_channel_number is %source_channel_number%

set channel_number=%source_channel_number%
if NOT "%~2"=="" (
	set channel_number_parameters= -ac %2
) else (
	if %channel_number% gtr 2 (
		Rem norm.bat doesn't supports mono or stereo only.
		Rem If it was extended, please delete this fix
		set channel_number=2
	)
)
set channel_number_parameters= -ac %channel_number%

echo channel_number is %channel_number%
echo channel_number_parameters is %channel_number_parameters%

Rem 1. Extracting Wav-file
	ffmpeg -i %1 -vn%channel_number_parameters% "%wave_name%"


	echo Unpacking of "%wave_name%" is done

Rem 2. Calling Normalization Script
	call norm.bat "%wave_name%"
	echo Normalization of "%wave_name%" is done

Rem 3. Packing Normalized Audio into Video
	ffmpeg ^
		-i %1 ^
		-i "%norm_wave_name%" ^
		-map 0:v ^
		-map 1:a ^
		-c:v copy ^
		-c:a aac ^
		"%norm_video_name%"
	echo Replacing audio for %1 is done

Rem 4. Deleting Temporary Files
	echo deleting temporary files

	del "%wave_name%"
	del "%norm_wave_name%"
	del %tmp_file%

echo Normalization of audio track for %1 is done
