set ready_name=%~n1_tb%~x1

ffmpeg -i %1 -c copy -video_track_timescale %2 "%ready_name%"

echo Setting Timebase %2 for %1 is done
