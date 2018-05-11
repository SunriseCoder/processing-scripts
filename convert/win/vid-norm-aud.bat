Rem 1. Extracting Audio
Rem 2. Normalizing Wav-file
Rem 3. Create new video file with normalized track

set wave_name=%1_

ffmpeg -i %1 -vn -ac 1 %wave_name%.wav
echo Unpacking of %wave_name% is done

java -cp D:\convert\scripts\portal-integrations-0.0.1-SNAPSHOT.jar app.integrations.App %wave_name%
echo Normalization of %wave_name% is done

ffmpeg ^
	-i %1 ^
	-i %wave_name%_out.wav ^
	-map 0:0 ^
	-map 1:0 ^
	-c:v copy ^
	-c:a aac ^
	-b:a 64k ^
	%1_offset.mp4
echo Replacing audio for %1 is done

echo deleting temporary files

del %wave_name%.wav
del %wave_name%_out.wav

echo Audio offset for %1 is done
