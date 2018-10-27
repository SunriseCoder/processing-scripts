REM Shifting audio track relative to video
REM %1 is input video file name
REM %2 is delay in seconds, could also be decimal (like 3.5)

ffmpeg.exe -i %1 -itsoffset %2 -i %1 -map 1:v -map 0:a -c copy %1_offset.mp4

echo Shifting audio track for %1 is done
