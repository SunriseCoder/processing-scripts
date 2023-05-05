Rem Usage: pdf-to-images.bat <pdf-file> <image-format (jpg, png, etc)> <pdf-rastering-resolutio (100, 300, etc)>

rem mogrify -verbose -format %2 -density %3x%3 %1 "page-%%03d.%2"
magick -verbose %1 -resize %3%% -quality 100 -sharpen 0x1.0 "page-%%03d.%2"
