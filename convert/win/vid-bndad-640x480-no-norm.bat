set scripts_path=D:\\convert\\scripts

ffmpeg ^
	-i %1 ^
	-i %scripts_path%\Chaitanya.academy_Logo_RGB_weiss.png ^
	-filter_complex "[1]scale=120:76[logo], [0][logo]overlay=50:20" ^
	-c:v libx264 ^
	-crf 23 ^
	-c:a copy ^
	%1_mid.mp4
echo Branding is done

echo file %scripts_path%\\video\\CA_Intro_640x480-30fps.mp4 > files_.txt
set file_name_with_quote=%1_mid.mp4
set file_name=%file_name_with_quote:"=%
echo file '%file_name%' >> files_.txt
echo file %scripts_path%\\video\\CA_Outro_640x480-30fps.mp4 >> files_.txt
ffmpeg -f concat -safe 0 -i files_.txt -c copy %1_tmp.mp4
rem del files_.txt
move %1_tmp.mp4 %1_ready.mp4
echo Intro and Outro are done

echo %0 is done
