set folder=..\old-branded

move *.mp3 %folder%
move *.mts %folder%
move *_logo.mp4 %folder%
move *.wav %folder%
move *.png %folder%

type index.html >> %folder%\index.html
del index.html
