set wave_name=%1_

ffmpeg -i %1 -vn -ac 1 %wave_name%.wav
echo Unpacking is done

java -cp D:\convert\scripts\portal-integrations-0.0.1-SNAPSHOT.jar app.integrations.App %wave_name%
echo Normalization is done

ffmpeg ^
	-i %1 ^
	-i %wave_name%_out.wav ^
	-i d:\convert\scripts\logo-big-bid.png ^
	-map 0:0 ^
	-map 1:0 ^
	-filter_complex "[2]scale=360:84[logo], [0][logo]overlay=0:552" ^
	-c:v libx264 ^
	-crf 23 ^
	-c:a aac ^
	-b:a 64k ^
	%1_.mp4
echo Branding is done

ffmpeg -i %wave_name%_out.wav -ar 22050 -q:a 9 %1.mp3
echo Packing done

echo deleting temporary files

del %wave_name%.wav
del %wave_name%_out.wav

echo Done
