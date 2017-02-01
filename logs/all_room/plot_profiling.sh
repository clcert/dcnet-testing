gnuplot -persist <<-EOFMarker
	set datafile separator ";"

	set terminal pngcairo enhanced font "arial,18" fontscale 1.0 size 1920,1080
	set size ratio 1 1

	set title 'Code Profiling with All participants sending'
	set xlabel "Number of Participants"
	set ylabel '% of total time'

	set xrange[-2:27]
	set yrange [0:100]

	set style data histograms

	set style fill solid 1.00 border lt -1
	set key outside right top vertical Left reverse noenhanced autotitle columnhead nobox
	set style histogram rowstacked title textcolor lt -1

	plot 'averages.csv' u 5:xtic(1), for [i=6:21] '' u i t column(i)
EOFMarker