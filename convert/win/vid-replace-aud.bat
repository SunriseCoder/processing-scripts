ffmpeg ^
	-i %1 ^
	-i %2 ^
	-map 0:0 ^
	-map 1:0 ^
	-c:v copy ^
	-c:a aac ^
	-b:a 64k ^
	%1_replaced.mp4
echo Audio track replacement for %1 is done
