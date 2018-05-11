Rem 1 - input, 2 - output, 3 - from, 4 - to

set wave_name=%1_

ffmpeg -i %1 ^
	-ac 1 ^
	%wave_name%.wav

java -cp D:\convert\scripts\portal-integrations-0.0.1-SNAPSHOT.jar app.integrations.App %wave_name%

Rem Logo is 276x150, offset: 90, 48
ffmpeg ^
	-i %1 -i %wave_name%_out.wav -i d:\convert\scripts\Chaitanya.academy_Logo_RGB_weiss.png ^
	-map 0:0 -map 1:0 ^
	-filter_complex "[0]yadif=mode=send_field:deint=interlaced[deint], [2]scale=276:150[logo], [deint][logo]overlay=90:48" ^
	-c:v libx264 -crf 23 ^
	-c:a aac -b:a 64k ^
	%1_.MTS
echo Branding is done

ffmpeg -i %wave_name%_out.wav -ar 22050 -q:a 9 %1.mp3
echo Packing of mp3 is done

echo deleting temporary files

rem del %wave_name%.wav
rem del %wave_name%_out.wav

echo %1 is done

:exit
