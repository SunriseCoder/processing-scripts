Rem 1. Convering Audio to Wav
Rem 2. Normalizing Wav-file

set wave_name=%~n1_src.wav
set norm_wave_name=%~n1_src_norm.wav
set mp3_name=%~n1.mp3

Rem To Wav
ffmpeg -i %1 -ac 1 "%wave_name%"
echo Unpacking of %wave_name% is done

Rem Normalization
call norm.bat "%wave_name%"
echo Normalization of %wave_name% is done

Rem Pack to mp3
ffmpeg -i "%norm_wave_name%" -ar 22050 -q:a 9 "%mp3_name%"
echo Packing of %1 is done

echo Deleting temporary files
del "%wave_name%"
del "%norm_wave_name%"

echo Normalization and Packing of %1 is done
