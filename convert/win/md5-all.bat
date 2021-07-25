@echo off
echo Calculation MD5 sums:

if exist md5.txt (
	del md5.txt
)

for /R . %%f in (*.*) do (
	echo %%f
    echo | set/p="%%f - " >> md5.txt
    certutil -hashfile "%%f" MD5 | findstr /V ":" >> md5.txt
)

if exist tmp.txt (
	del tmp.txt
)

echo Done
pause
