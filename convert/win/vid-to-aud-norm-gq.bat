set wave_name=%1.wav

ffmpeg -i %1 %wave_name%
call norm.bat %wave_name%

ffmpeg -i %wave_name% -q:a 5 %1.mp3

del %wave_name%
del %wave_name%_norm.wav

echo Vidio to mp3 with normalization is done for %1
