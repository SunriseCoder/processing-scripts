Rem Usage: pdf-to-images.bat <pdf-file> <image-format (jpg, png, etc)> <pdf-rastering-resolutio (100, 300, etc)>

mogrify -verbose -format %2 -density %3"x"%3 %1
rem convert -verbose %1 -resize 500%% -quality 100 -flatten -sharpen 0x1.0 "page-%%03d.%2"
