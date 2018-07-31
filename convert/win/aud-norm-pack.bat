Rem 1. Convering Audio to Wav
Rem 2. Normalizing Wav-file

set wave_name=%1.wav

Rem To Wav
ffmpeg -i %1 -ac 1 %wave_name%
echo Unpacking of %wave_name% is done

Rem Normalization
call norm.bat %wave_name%
echo Normalization of %wave_name% is done

Rem Pack to mp3
ffmpeg -i %1.wav_norm.wav -ar 22050 -q:a 9 %1_norm.mp3
echo Packing of %1 is done

echo Deleting temporary files
del %wave_name%
del %1.wav_norm.wav

echo Normalization and Packing of %1 is done
