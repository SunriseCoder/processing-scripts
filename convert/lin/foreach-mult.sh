#!/bin/bash

if [ $# -lt 2 ]; then
	echo "Usage: foreach.sh <command> <mask> [command_args]"
	echo "       where <mask> is like: \"*.mp4\""
	exit
fi

for file in $2; do
	echo Executing command $1 for file $file

	# Command and file name
	command="$1"
	args[0]=$file

	# Appending arguments
	child_index=1
	parent_index=3
	while [ $parent_index -le $# ]; do
		args[$child_index]=${!parent_index}
		let child_index=child_index+1
		let parent_index=parent_index+1
	done

	echo Executing $command ${args[@]}
	$command "${args[@]}" &

	# Exiting whole batch on error
	if ! [ $? -eq 0 ]; then
			echo exit $?
	fi

done
