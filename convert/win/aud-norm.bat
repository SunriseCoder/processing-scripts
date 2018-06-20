Rem 1. Convering Audio to Wav
Rem 2. Normalizing Wav-file

set wave_name=%1.wav

ffmpeg -i %1 -ac 1 %wave_name%
echo Unpacking of %wave_name% is done

call norm.bat %wave_name%
echo Normalization of %wave_name% is done

echo deleting temporary files

del %wave_name%

echo Normalization of audio track for %1 is done
