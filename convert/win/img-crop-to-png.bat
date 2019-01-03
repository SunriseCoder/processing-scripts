echo Cropping and converting %1 to PNG

set x=%2
set y=%3
set w=%4
set h=%5

ffmpeg -i %1 -vf "crop=%w%:%h%:%x%:%y%" %1.png 
