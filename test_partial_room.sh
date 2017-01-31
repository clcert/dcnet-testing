#! /bin/bash

for (( i=1; i<=28; i++ ))
do
	sh containers.sh -n 28 -t 2 -s 140 -m $i -l logs/partial_room/$i 
	echo Test with ${i} messages done!
	sleep 15
done
