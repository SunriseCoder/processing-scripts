java -cp D:\convert\scripts\portal-integrations-0.0.1-SNAPSHOT.jar app.integrations.App %1
echo Normalization done

ffmpeg -i %1_out.wav -ar 22050 -q:a 9 %1.mp3
echo Packing done