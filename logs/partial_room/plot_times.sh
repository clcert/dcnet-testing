gnuplot -persist <<-EOFMarker
	set datafile separator ";"

	set title "Some Participants Sending (Room of 28)"
	set xlabel "Number of Messages"
	set ylabel "Time [seconds]"

	set key at 20,760

	set xrange[1:28]
	set yrange[0:800]

	f(x) = a1*x**2 + b1*x + c1
	fit f(x) 'averages.csv' u (\$1):(\$2) via a1, b1, c1

	g(x) = a2*x**2 + b2*x + c2
	fit g(x) 'averages.csv' u (\$1):(\$3) via a2, b2, c2

	h(x) = a3*x**2 + b3*x + c3
	fit h(x) 'averages.csv' u (\$1):(\$4) via a3, b3, c3

	plot 'averages.csv' u (\$1):(\$2) title 'Total Time', 'averages.csv' u (\$1):(\$3) title 'First Message', 'averages.csv' u (\$1):(\$4) title 'Average Round Time', f(x) notitle, g(x) notitle, h(x) notitle
EOFMarker
