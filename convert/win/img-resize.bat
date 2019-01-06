echo Resizing %1 to "%2"x%3 %4

set filename=%1
set w=%2
set h=%3
set ext=%4
ffmpeg -i %filename% -vf "scale=%w%:%h%" resized-%w%x%h%-%filename%%ext%
