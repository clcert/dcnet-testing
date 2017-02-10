import csv

averages = open('averages.csv', 'w+')
for i in range(3,29):
	averages.write(str(i))
	file_name = str(i) + '.csv'
	for j in range(0, 20):
		with open(file_name, newline='') as f:
			reader = csv.reader(f, delimiter=';')
			the_numbers = [float(row[j]) for row in reader]
			average = sum(the_numbers) / len(the_numbers)
			averages.write(';' + str(average))
	averages.write('\n')