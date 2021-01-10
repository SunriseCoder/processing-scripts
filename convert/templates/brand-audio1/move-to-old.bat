set folder=..\old-branded-audios

move *.mp3 %folder%
move *.wav %folder%
move *.png %folder%

type index.html >> %folder%\index.html
del index.html
