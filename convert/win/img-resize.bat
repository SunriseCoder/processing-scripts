echo Resizing %1 to %2 and save as %3

set filename=%1
set resize=%2
set ext=%3

mogrify -resize %resize% -format %ext% %filename%
