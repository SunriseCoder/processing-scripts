set folder=..\old-concat

IF NOT EXIST %folder% (
	mkdir %folder%
)

move *.mts %folder%
move *.png %folder%
move *.mov %folder%

del *.mp4
del *.wav

type index.html >> %folder%\index.html
del index.html

cd concat-branded-videos
call move-to-old.bat
