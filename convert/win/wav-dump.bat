java -cp %CONVERT_HOME%\res\portal-integrations-0.0.2-SNAPSHOT.jar app.integrations.AudioDump %1 %2 "m"

rem img-add-to-html.sh %2

setlocal enabledelayedexpansion
set RAW_URL=%2
set SAFE_URL=%RAW_URL:"=%
echo ^<img src="%SAFE_URL%" /^>^<br /^> >> index.html

Echo Wav dump of %1 is done
