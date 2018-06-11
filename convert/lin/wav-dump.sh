#!/bin/bash

# $1 - wave-filename
# $2 - png-filename (optional)
# $3 - options (comma-separated)
#      m - add math meanings to the image (statistic)
#      d - add deltas count to the image (statistic)
#      a - append new image to an existing image

echo Creating audio dump for "$1"

args[0]="$1" # 1-st parameter as options

if [ -z "$2" ] # 2-nd parameter as filename
then
	args[1]="$1.png"
else
	args[1]="$2"
fi

if [ ! -z "$3" ]; then
	args[2]="$3"
fi

java -cp $CONVERT_HOME/res/portal-integrations-0.0.2-SNAPSHOT.jar app.integrations.AudioDump "${args[@]}"
