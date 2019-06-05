Rem Usage: img-fit <input_file> <output_width> <output_height> <color (FF8800)>

set input_file=%1
set output_width=%2
set output_height=%3
set color=%4
set output_file=%~n1_fit%~x1

Rem cli.FitImage <input_file> <output_width> <output_height> <color (FF8800)> <output_file>
java -cp %CONVERT_HOME%\res\jars\scan-tools-0.0.1-SNAPSHOT-jar-with-dependencies.jar ^
	cli.FitImage "%input_file%" %output_width% %output_height% %color% %output_file%
