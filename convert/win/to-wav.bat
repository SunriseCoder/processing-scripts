set wave_name=%1.wav

Rem To Wav
ffmpeg -i %1 -ac 1 %wave_name%
echo Unpacking of %wave_name% is done
