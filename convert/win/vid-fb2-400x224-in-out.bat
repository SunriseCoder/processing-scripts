set scripts_path=D:\\convert\\scripts

echo file %scripts_path%\\video\\CA_Intro_400x224-30fps.mp4 > files_.txt
set file_name_with_quote=%1
set file_name=%file_name_with_quote:"=%
echo file '%file_name%' >> files_.txt
echo file %scripts_path%\\video\\CA_Outro_400x224-30fps.mp4 >> files_.txt

ffmpeg -fflags +sortdts -f concat -safe 0 ^
	-i files_.txt ^
	-c copy ^
	-report ^
	%1_tmp.mp4

rem del files_.txt

move %1_tmp.mp4 %1_ready.mp4
echo Intro and Outro are done
