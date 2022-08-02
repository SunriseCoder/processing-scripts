Rem Usage: md5 <input-filename> [checksum-filename]

set checksum_filename=%~n1.md5
if not "%2"=="" set checksum_filename=%2

md5sum %1 > %checksum_filename%

echo MD5-Checksum for file %1 is generated
pause
