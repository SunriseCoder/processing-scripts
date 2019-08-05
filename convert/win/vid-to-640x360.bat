set video_output_name=%~n1_scaled.mp4

ffmpeg ^
	-i %1 ^
	-c:v libx264 ^
	-crf 23 ^
	-vf "scale=640:360" ^
	-c:a aac ^
	-q:a 64k ^
	"%video_output_name%"

echo Scaling of %1 is done
