set wave_name=%1.wav

ffmpeg -i %1 -ac 1 %wave_name%
call norm.bat %wave_name%

ffmpeg -i %wave_name% -ar 22050 -q:a 9 %1.mp3

del %wave_name%
del %wave_name%_norm.wav

echo Vidio to mp3 with normalization is done for %1
