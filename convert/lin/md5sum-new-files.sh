#!/bin/bash

for file in *; do

	if [[ $file != *.md5 ]]; then
		
		if [ ! -s "$file.md5" ]; then
			echo File $file has no md5sum yet, computing...
			
			md5sum "$file" > "$file.md5"
			echo "#" `ls -la --time-style=full-iso "$file"` >> "$file.md5"
		fi

	fi

done
