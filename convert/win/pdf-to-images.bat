Rem Usage: pdf-to-images.bat <pdf-file> <image-format (jpg, png, etc)>

mogrify -verbose -format %2 %1
