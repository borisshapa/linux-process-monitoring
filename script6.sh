#!/bin/bash

last_ppid=-1
sum=0
cnt=1
ans=""

while read line; do
	if [[ -z "$line" ]]; then
		continue
	fi

	ppid=$(echo $line | grep -Ehso "Parent_ProcessID=[[:digit:]]+" | grep -Eo "[[:digit:]]+")
	sleep_avg=$(echo $line | grep -Ehso "Average_Sleeping_Time=[[:digit:]]+" | grep -Eo "[[:digit:]]+")
	if [[ "$last_ppid" == "$ppid" ]]; then
		sum=$(echo "$sum + $sleep_avg" | bc)
		cnt=$(echo "$cnt + 1" | bc)
	elif [[ "$last_ppid" != "-1" ]]; then
		average=$(echo "$sum / $cnt" | bc)
		sum=$sleep_avg
		cnt=1
		ans="$ans Average_Sleeping_Children_of_ParentID=$last_ppid is $average \n"		
	fi
	last_ppid=$ppid
	ans="$ans$line\n"
done < status.txt

average=$(echo "$sum / $cnt" | bc)
ans="$ans Average_Sleeping_Children_of_ParentID=$last_ppid is $average \n"
echo -e "$ans" > average.txt
