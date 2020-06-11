#!/bin/bash

ps a -o pid | tail -n +2 | xargs -L1 -I % awk '{ print % " " $2 - $3 }' /proc/%/statm 2>/dev/null | sort -nk 2 | tr " " ":" > diff.txt 
