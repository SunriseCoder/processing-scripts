Rem Input:
Rem %1 - Input filename (wav)

Rem 1. Getting number of channels
	ffprobe -v error -select_streams a:0 -show_entries stream=channels -of csv=p=0 %1 > tmp.txt
	set /p number_of_channels=<tmp.txt
	del tmp.txt

Rem 2. Preparing Operations
	set /a max_channel_number=%number_of_channels%-1
	set operations=
	
	for /l %%a in (0, 1, %max_channel_number%) Do (
		call set "operations=%%operations%%,a-%%a"
	)

	set operations=%operations:~1%

Rem 3. Normalization
	java -cp %CONVERT_HOME%\res\portal-integrations-0.0.2-SNAPSHOT.jar app.integrations.AudioManipulations %1 "%~n1_norm.wav" %operations%
	echo Normalization of %1% is done

Rem 4. Dump Wave Files
	call wav-dump.bat %1 "%~n1.png"
	call wav-dump.bat "%~n1_norm.wav" "%~n1_norm.png"
