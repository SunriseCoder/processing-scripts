set output_file_name=%~n1_vol%~x1

ffmpeg -i %1 -vcodec copy -af "volume=%2" "%output_file_name%"
