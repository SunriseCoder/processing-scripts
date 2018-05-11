ffmpeg -i %1 -ac 1 -ar 22050 %1.wav
echo Decompression is done

java -cp D:\convert\scripts\portal-integrations-0.0.1-SNAPSHOT.jar app.integrations.App %1
echo Normalization is done

ffmpeg -i %1_out.wav -ar 22050 -q:a 9 %1.mp3
echo Packing of %1 is done
