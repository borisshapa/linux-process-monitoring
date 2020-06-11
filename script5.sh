#!/bin/bash

ans=""
for pid in $(ps a -o pid | tail -n +2); do
	status_file="/proc/"$pid"/status"
	shed_file="/proc/"$pid"/sched"
	cat $status_file
	echo -e "\n"
	ppid=$(grep -Ehs "PPid:\s(.+)" $status_file | grep -Eo "[[:digit:]]+")
	pid=$(grep -Ehsw "Pid:\s(.+)" $status_file | grep -Eo "[[:digit:]]+")
	sum_exec=$(grep -Ehs "se.sum_exec_runtime" $shed_file | grep -Eo "[0-9]+[.][0-9]+" | awk 'int($1)')
	nr_switches=$(grep -Ehs "nr_switches" $shed_file | grep -Eo "[[:digit:]]+")
	if [[ "$sum_exec" != "" && "$nr_switches" != "" ]]; then
		avg_atom=$(echo "$sum_exec / $nr_switches" | bc)
		if [[ "$pid" != "" && "" != "$ppid" ]]; then
			ans="$ans Process=$pid : Parent_ProcessID=$ppid : Average_Sleeping_Time=$avg_atom \n"
		fi
	fi
done
echo -e "$ans" | sort -nt =  -k3 > status.txt

