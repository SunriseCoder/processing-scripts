Rem Merge 2 videos as split screen

ffmpeg ^
	-i %1 ^
	-i %2 ^
	-filter_complex "[0:v]scale=iw/2:ih/2[s1];[1:v]scale=iw/2:ih/2[s2];[s1]pad=iw*2:ih[pad];[pad][s2]overlay=W/2:0[res]" ^
	-map [res] -map 0:a ^
	-c:v libx264 -crf 23 ^
	-c:a copy ^
	%3
