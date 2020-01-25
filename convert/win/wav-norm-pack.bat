set norm_wave_name=%~n1_norm.wav
set result_name=%~n1_norm.mp3

call norm.bat %1
echo Normalization of %1 is done

ffmpeg -i "%norm_wave_name%" -ar 22050 -q:a 9 "%result_name%"
echo Packing of %1 is done

echo Deleting temporary files
del "%norm_wave_name%"

echo Normalization and Packing of %1 is done
