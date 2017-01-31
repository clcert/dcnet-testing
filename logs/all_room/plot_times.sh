gnuplot -persist <<-EOFMarker
	set datafile separator ";"

	set title "All Participants Sending"
	set xlabel "Number of Participants"
	set ylabel "Time [seconds]"

	set key at 25,760

	set xrange[1:28]
	set yrange[0:800]

	plot 'averages.csv' u (\$1):(\$2) title 'Total Time', 'averages.csv' u (\$1):(\$3) title 'First Message', 'averages.csv' u (\$1):(\$4) title 'Average Round Time'
EOFMarker
