set scripts_path=D:\\convert\\scripts
set wave_name=%1_

ffmpeg -i %1 -vn -ac 1 -ar 48000 %wave_name%.wav
echo Unpacking is done

java -cp D:\convert\scripts\portal-integrations-0.0.1-SNAPSHOT.jar app.integrations.App %wave_name%
echo Normalization is done

ffmpeg ^
	-i %1 ^
	-i %wave_name%_out.wav ^
	-i %scripts_path%\Chaitanya.academy_Logo_RGB_weiss.png ^
	-map 0:0 ^
	-map 1:0 ^
	-filter_complex "[2]scale=84:52[logo], [0][logo]overlay=24:12" ^
	-c:v libx264 ^
	-crf 23 ^
	-c:a aac ^
	-b:a 64k ^
	%1_mid.mp4
echo Branding is done

echo file %scripts_path%\\video\\CA_Intro_400x224-30fps.mp4 > files_.txt
set file_name_with_quote=%1_mid.mp4
set file_name=%file_name_with_quote:"=%
echo file '%file_name%' >> files_.txt
echo file %scripts_path%\\video\\CA_Outro_400x224-30fps.mp4 >> files_.txt
ffmpeg -f concat -safe 0 -i files_.txt -c copy %1_tmp.mp4
rem del files_.txt
move %1_tmp.mp4 %1_ready.mp4
echo Intro and Outro are done

ffmpeg -i %wave_name%_out.wav -ar 22050 -q:a 9 %1.mp3
echo Packing done

echo deleting temporary files

del %wave_name%.wav
del %wave_name%_out.wav

echo Done
