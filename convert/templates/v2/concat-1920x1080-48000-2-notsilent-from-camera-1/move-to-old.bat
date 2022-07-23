set folder=..\old-concat-nonsilent

IF NOT EXIST %folder% (
	mkdir %folder%
)

move *.mts %folder%
move *.png %folder%
move *.mov %folder%

del *.mp4
del *.wav

IF EXIST index.html (
	type index.html >> %folder%\index.html
	del index.html
)

Rem Cleanup: old-concat-branded
cd old-concat-branded

set folder=..\%folder%\old-concat-branded

IF NOT EXIST %folder% (
	mkdir %folder%
)

move 2*.mp4 %folder%
del files.txt
del joints.txt

IF EXIST concat.mp4 (
	del concat.mp4
)
