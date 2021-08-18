set folder=.
set attribute=lastModifiedTime

if not "%1"=="" set folder=%1
if not "%2"=="" set attribute=%2

java -cp %CONVERT_HOME%/res/jars/script-tools-0.0.1-SNAPSHOT-jar-with-dependencies.jar rename.FileRenameApp %folder% %attribute%

pause
