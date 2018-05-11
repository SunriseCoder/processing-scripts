ffmpeg ^
	-i %1 ^
	-c:v libx264 -crf 23 ^
	-c:a aac -b:a 64k ^
	%1_.%2
echo Repack of %1 is done

:exit
