set wave_name=%~n1.wav
ffmpeg -i %1 "%wave_name%"
