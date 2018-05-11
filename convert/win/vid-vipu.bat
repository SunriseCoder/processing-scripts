Rem 1 - input, 2 - output, 3 - from, 4 - to

set wave_name=%1_

ffmpeg -i %1 ^
	-map_channel 0.1.2 ^
	%wave_name%.wav

java -cp D:\convert\scripts\portal-integrations-0.0.1-SNAPSHOT.jar app.integrations.App %wave_name%

ffmpeg ^
	-i %1 -i %wave_name%_out.wav -i d:\convert\scripts\logo-big-bid.png ^
	-map 0:0 -map 1:0 ^
	-filter_complex "[0]yadif=mode=send_field:deint=interlaced[deint], [2]scale=772:184[logo], [deint][logo]overlay=32:872" ^
	-c:v libx264 -crf 23 ^
	-c:a aac -b:a 64k ^
	%1_.MTS

echo deleting temporary files

del %wave_name%.wav
rem del %wave_name%_out.wav

echo %1 is done

:exit
