gnuplot -persist <<-EOFMarker
	set datafile separator ";"

	set title "Some Participants Sending (Room of 28)"
	set xlabel "Number of Messages"
	set ylabel "Time [seconds]"

	set key at 20,760

	set xrange[1:28]
	set yrange[0:800]

	plot 'averages.csv' u (\$1):(\$2) title 'Total Time', 'averages.csv' u (\$1):(\$3) title 'First Message', 'averages.csv' u (\$1):(\$4) title 'Average Round Time'
EOFMarker
