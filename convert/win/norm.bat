java -cp %CONVERT_HOME%\res\portal-integrations-0.0.2-SNAPSHOT.jar app.integrations.AudioManipulations %1 %1_norm.wav a-0
echo Normalization of %1% is done
call wav-dump.bat %1 %1.png
call wav-dump.bat %1_norm.wav %1_norm.png
