echo Resizing %1 to "%2"x%3

set filename=%1
set w=%2
set h=%3
ffmpeg -i %filename% -vf "scale=%w%:%h%" resized-%w%x%h%-%filename%
