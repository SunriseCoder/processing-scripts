Rem - Copying everything as-is to mp4-container, just swaping the order of tracks

ffmpeg -i %1 -c copy %1.mp4
echo Converting of %1 to mp4 is done
