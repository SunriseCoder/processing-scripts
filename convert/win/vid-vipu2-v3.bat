set scripts_path=D:\\convert\\scripts
set wave_name=%1_

ffmpeg -i %1 ^
	-ac 1 ^
	%wave_name%.wav

java -cp %scripts_path%\portal-integrations-0.0.1-SNAPSHOT.jar app.integrations.App %wave_name%

Rem Logo is 276x150, offset: 90, 48
ffmpeg ^
	-i %1 -i %wave_name%_out.wav -i %scripts_path%\Chaitanya.academy_Logo_RGB_weiss.png ^
	-map 0:0 -map 1:0 ^
	-filter_complex "[0]yadif=mode=send_field:deint=interlaced[deint], [2]scale=276:150[logo], [deint][logo]overlay=90:48" ^
	-c:v libx264 -crf 23 ^
	-c:a aac -b:a 64k ^
	%1_mid.MTS
echo Branding is done

echo file %scripts_path%\\video\\CA_Intro_1920x1080-50fps.MTS > files_.txt
set file_name_with_quote=%1_mid.MTS
set file_name=%file_name_with_quote:"=%
echo file '%file_name%' >> files_.txt
echo file %scripts_path%\\video\\CA_Outro_1920x1080-50fps.MTS >> files_.txt
ffmpeg -f concat -safe 0 -i files_.txt -c copy %1_tmp.MTS
rem del files_.txt
move %1_tmp.MTS %1_ready.MTS
echo Intro and Outro are done

ffmpeg -i %wave_name%_out.wav -ar 22050 -q:a 9 %1.mp3
echo Packing of mp3 is done

echo deleting temporary files

rem del %wave_name%.wav
rem del %wave_name%_out.wav
rem del %1_mid.MTS

echo %1 is done

:exit
