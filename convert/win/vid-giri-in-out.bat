setlocal ENABLEDELAYEDEXPANSION
set scripts_path=D:\\convert\\scripts

echo file %scripts_path%\\video\\CA_Intro_1920x1080-25fps.MTS > files_.txt
set file_name_with_quote=%1
set file_name=%file_name_with_quote:"=%
echo file '%file_name%' >> files_.txt
echo file %scripts_path%\\video\\CA_Outro_1920x1080-25fps.MTS >> files_.txt
ffmpeg -f concat -safe 0 -i files_.txt -c copy %1_x.MTS
rem del files_.txt
echo Intro and Outro for %1 are done

:exit
