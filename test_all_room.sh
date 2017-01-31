#! /bin/bash

for (( i=30; i<=30; i++ ))
do
	sh containers.sh -n $i -t 2 -s 140 -m $i -l logs/all_room/$i 
	echo Test with ${i} participants done!
	sleep 15
done
