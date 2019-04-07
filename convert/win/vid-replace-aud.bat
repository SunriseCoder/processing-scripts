set output_filename=%~n1_replaced%~x1

ffmpeg ^
	-i %1 ^
	-i %2 ^
	-map 0:0 ^
	-map 1:0 ^
	-c:v copy ^
	-c:a aac ^
	%output_filename%
echo Audio track replacement for %1 is done
