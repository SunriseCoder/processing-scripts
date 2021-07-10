set folder=..\..\old-concat-branded

IF NOT EXIST %folder% (
	mkdir %folder%
)

move 2*.mp4 %folder%
del files.txt
del concat.mp4
