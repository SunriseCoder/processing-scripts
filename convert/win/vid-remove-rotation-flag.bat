ffmpeg -i %1 -c copy -metadata:s:v:0 rotate=0 %~n1_unrotated.mp4
