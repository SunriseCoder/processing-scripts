set scripts_path=D:\\convert\\scripts
set wave_name=%1_

ffmpeg -i %1 ^
	-ac 1 ^
	%wave_name%.wav

java -cp %scripts_path%\portal-integrations-0.0.1-SNAPSHOT.jar app.integrations.App %wave_name%

Rem Logo is 276x150, offset: 90, 48
ffmpeg ^
	-i %1 -i %wave_name%_out.wav ^
	-map 0:0 -map 1:0 ^
	-c:v libx264 -crf 23 ^
	-c:a aac -b:a 64k ^
	%1_.mp4
echo Branding is done

echo deleting temporary files

rem del %wave_name%.wav
rem del %wave_name%_out.wav

echo %1 is done

:exit
