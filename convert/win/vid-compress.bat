Rem Compressing video to x264 CRF=23

ffmpeg ^
	-i %1 ^
	-c:v libx264 -crf 23 ^
	-c:a copy ^
	%1_compressed.mp4
echo Compressing of %1 is done
