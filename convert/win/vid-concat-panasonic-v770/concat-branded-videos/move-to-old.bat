set folder=..\..\old-concat-branded

IF NOT EXIST %folder% (
	mkdir %folder%
)

move 20*.mp4 %folder%
del files.txt
del concat.mp4
