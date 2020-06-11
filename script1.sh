#!/bin/bash

user="borisshapa"
ps -U "$user" -o pid,cmd | tail -n +2 | awk '{pid=$1; $1=""; print pid ":" $0}'
