set video_trans_name=%~n1_trans%~x1
set video_result_name=%~n1_stab%~x1
ffmpeg -i %1 -vf vidstabdetect=show=1 %video_trans_name%

ffmpeg -i %1 -vf vidstabtransform=optzoom=0:crop=black,unsharp %video_result_name%