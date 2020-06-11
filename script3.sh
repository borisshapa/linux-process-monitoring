#!/bin/bash

for i in /proc/[0-9]*/exe; do
	rl=$(readlink $i)
	if [[ "$rl" =~ ^/sbin/ ]]; then
		echo $i | grep -Eo "[[:digit:]]+" > sbinproc.txt
       	fi	       
done
