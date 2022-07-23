set concat_name=concat.mp4

if NOT "%1%"=="" (
	set concat_name=%1
)

java -cp %CONVERT_HOME%/res/jars/script-tools-0.0.1-SNAPSHOT-jar-with-dependencies.jar files.ListForFFMpegConcat

ffmpeg -f concat -safe 0 -i files.txt -c copy "%concat_name%"

echo Concat is done

pause
