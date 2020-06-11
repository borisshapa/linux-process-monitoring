#!/bin/bash

for i in /proc/[0-9]*/exe; do
        rl=$(readlink $i)
	ln -s $rl "/home/borisshapa/labs_os/lab3/bins/" 2>/dev/null
done
