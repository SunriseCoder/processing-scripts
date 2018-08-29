#!/bin/bash

if [ -z "$1" ]
then
	md5sum_filename="md5sums"
else
	md5sum_filename="$1"
fi

find -type f \( -not -name "$md5sum_filename" \) -exec md5sum '{}' \; > $md5sum_filename

echo Checksum is done