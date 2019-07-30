ffmpeg ^
	-i %1 ^
	-c:v libx264 ^
	-crf 23 ^
	-vf "scale=640:360" ^
	-c:a aac ^
	-q:a 64k ^
	%1_scaled.mp4

echo Scaling of %1 is done
