ffmpeg -i %1 ^
	-filter:v "crop=%2:%3:%4:%5" ^
	-c:v libx264 -crf 23 ^
	-c:a copy ^
	%1_crop.mp4
