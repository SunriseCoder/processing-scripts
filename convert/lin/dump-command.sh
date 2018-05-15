#!/bin/bash

arg_index=0
while [ $arg_index -le $# ]; do
	arg=${!arg_index}

	if [[ "$arg" =~ [[:space:]] ]]; then
		command="$command \"$arg\""
	else
		command="$command $arg"
	fi

	let arg_index=arg_index+1
done

echo Dump command: $command
