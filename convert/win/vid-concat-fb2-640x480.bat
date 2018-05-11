set scripts_path=D:\\convert\\scripts
set wave_name=%1_

ffmpeg ^
	-f concat ^
	-i files.txt ^
	-i %scripts_path%\Chaitanya.academy_Logo_RGB_weiss.png ^
	-map 0:0 ^
	-map 0:1 ^
	-filter_complex "[1]scale=120:76[logo], [0][logo]overlay=50:20" ^
	-c:v libx264 ^
	-crf 23 ^
	-c:a aac ^
	-b:a 64k ^
	%1_.mp4
echo Branding is done

ffmpeg -i %1 -vn -ac 1 %wave_name%.wav
echo Unpacking is done

java -cp D:\convert\scripts\portal-integrations-0.0.1-SNAPSHOT.jar app.integrations.App %wave_name%
echo Normalization is done

ffmpeg ^
	-i %1_.mp4 ^
	-i %wave_name%_out.wav
	-map 0:0 ^
	-map 1:0 ^
	-c:v copy ^
	-c:a aac ^
	-b:a 64k ^
	%1_ready.mp4
echo Normalized audio replacement done

ffmpeg -i %wave_name%_out.wav -ar 22050 -q:a 9 %1.mp3
echo Packing done

echo deleting temporary files

del %wave_name%.wav
del %wave_name%_out.wav

echo Done
