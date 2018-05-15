#!/bin/bash

# Use "a" as second parameter to append to an existing image
# Use also "m" and "d" (comma-separated) as second parameter as options

echo Creating audio dump for "$1"

args[0]="$1"

if [ -z "$2" ]; then
	args[1]="$1.png"
else
	args[1]="$2"
fi

if [ ! -z "$3" ]; then
	args[2]="$3"
fi

java -cp $CONVERT_HOME/res/portal-integrations-0.0.2-SNAPSHOT.jar app.integrations.AudioDump "${args[@]}"
