set folder=.

if not "%1"=="" set folder=%1

java -cp %CONVERT_HOME%/res/jars/script-tools-0.0.1-SNAPSHOT-jar-with-dependencies.jar rename.FileAttributesDumpApp %folder%

pause
