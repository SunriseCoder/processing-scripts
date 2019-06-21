Rem Usage: vid-to-png.bat <input_file_name> <output_file_extension>

set image_prefix=%~n1
set image_extension=%2

ffmpeg -i %1 "%image_prefix%-%%07d.%image_extension%"
