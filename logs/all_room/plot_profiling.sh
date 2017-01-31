gnuplot -persist <<-EOFMarker
	set datafile separator ";"

	set title 'Code Profiling with All participants sending'
	set xlabel "Number of Messages"
	set ylabel '% of total time'

	set xrange[-2:27]
	set yrange [0:100]
	unset xtics

	set style data histograms

	set style fill   solid 1.00 border lt -1
	set key outside right top vertical Left reverse noenhanced autotitle columnhead nobox
	set style histogram rowstacked title textcolor lt -1
	
	plot 'averages.csv' u 5:xtic(1), for [i=6:21] '' u i t column(i)
EOFMarker