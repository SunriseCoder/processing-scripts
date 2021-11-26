ffmpeg -i %1 -c copy -map 0:v -map 0:a "%~n1_fixed%~x1"
