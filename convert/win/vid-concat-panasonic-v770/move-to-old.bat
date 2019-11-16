set folder=..\old-concat

move *.mts %folder%
move *.png %folder%

del *.mp4
del *.wav

type index.html >> %folder%\index.html
del index.html

cd concat-branded-videos
call move-to-old.bat
