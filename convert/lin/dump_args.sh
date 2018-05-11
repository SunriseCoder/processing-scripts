#!/bin/bash

echo Dump args of $@

arg_index=0
while [ $arg_index -le $# ]; do
	arg=${!arg_index}
	echo \$$arg_index: $arg
	let arg_index=arg_index+1
done
