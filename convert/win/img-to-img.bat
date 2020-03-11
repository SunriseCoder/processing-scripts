echo Converting %1 to %2

set filename=%1
set ext=%2

mogrify -format %ext% %filename%
