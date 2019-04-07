java -cp %CONVERT_HOME%\res\portal-integrations-0.0.2-SNAPSHOT.jar app.integrations.AudioManipulations %1 %~n1_norm.wav a-0,a-1
echo Normalization of %1% is done
call wav-dump.bat %1 %~n1.png
call wav-dump.bat %~n1_norm.wav %~n1_norm.png
