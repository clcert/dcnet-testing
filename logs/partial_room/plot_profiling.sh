gnuplot -persist <<-EOFMarker
	set datafile separator ";"

	set title 'Code Profiling with some participants sending (Room of 28)'
	set xlabel "Number of Messages"
	set ylabel '% of total time'
	set key invert reverse Left outside

	set grid y
	set grid x

	set xrange[-3:30]
	set yrange [0:100]
	set xtics 1

	set style data histograms
	set bar 1.000000 front
	set boxwidth 1 absolute
	set style fill   solid 1.00 border lt -1
	set style circle radius graph 0.02, first 0.00000, 0.00000 
	set style ellipse size graph 0.05, 0.03, first 0.00000 angle 0 units xy
	set key outside right top vertical Left reverse noenhanced autotitle columnhead nobox
	set key invert samplen 4 spacing 1 width 0 height 0 
	set style histogram rowstacked title textcolor lt -1
	set style textbox transparent margins  1.0,  1.0 border

	set xtics border in scale 0,0 nomirror rotate by -45  autojustify

	plot 'averages.csv' u 5:xtic(1), for [i=6:21] '' u i t column(i)
EOFMarker