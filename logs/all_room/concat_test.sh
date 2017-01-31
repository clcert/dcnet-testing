#! /bin/bash

for (( i=3; i<=30; i++ ))
do
	cd $i
	cat *.csv > ../$i.csv
	cd ..
done
