gnuplot -persist <<-EOFMarker
	set datafile separator ";"

	set title 'Code Profiling with All participants sending'
	set xlabel "Number of Messages"
	set ylabel '% of total time'
	set key invert reverse Left outside

	set grid y
	set grid x

	set xrange[1:30]
	set yrange [0:100]
	set xtics 1
	set border 3

	set style data histograms
	set style histogram rowstacked
	set style fill solid border -1
	set boxwidth 0

	plot for [i=5:21] 'averages.csv' u i t column(i)
	# plot 'averages.csv' u xtic(1) notitle, for [i=5:19] '' u i 
EOFMarker