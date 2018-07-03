ffmpeg ^
	-i %1 ^
	-c:v libx264 ^
	-crf 23 ^
	-vf "scale=640:360" ^
	-c:a aac ^
	-q:a 64k ^
	%1_scaled.mp4
echo Scaling for %1 is done

echo deleting temporary files

del %wave_name%
del %wave_name%_norm.wav

echo Scaling of %1 is done
