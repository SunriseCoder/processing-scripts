call norm.bat %1
echo Normalization of %1 is done

ffmpeg -i %1_norm.wav -ar 22050 -q:a 9 %1_norm.mp3
echo Packing of %1 is done

echo Deleting temporary files
del %1_norm.wav

echo Normalization and Packing of %1 is done
