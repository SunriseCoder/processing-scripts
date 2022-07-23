set folder=..\old-single-vids-silent

IF NOT EXIST %folder% (
	mkdir %folder%
)

move *.mp3 %folder%
move *.mts %folder%
move *.mov %folder%
move *_logo.mp4 %folder%
move *.wav %folder%
move *.png %folder%

IF EXIST index.html (
	type index.html >> %folder%\index.html
	del index.html
)
