Rem Usage: vid-reencode-dnxhr <input-file> [output-file]
Rem Encodes video to almost-lossless format DNxHD-HQ (High-Quality 8-bit 4:2:2)

set final_video_name=%~n1_dnxhr.mov

ffmpeg ^
	-i %1 ^
	-c:v dnxhd -profile:v dnxhr_hq ^
	-c:a pcm_s16le ^
	"%final_video_name%"
