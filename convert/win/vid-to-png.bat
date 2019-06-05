Rem Usage: vid-to-png.bat <input_file_name> <fps>

set image_prefix=%~n1

ffmpeg -i %1 -vf fps=%2 "%image_prefix%-%%07d.png"
