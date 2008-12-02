#!/usr/bin/ipython -i

import sys
import csv

csv_name=sys.argv[1]
if csv_name[-4:] == '.csv':
    csv_reader=csv.reader(open(csv_name))
else:
    csv_reader=csv.reader(open(csv_name), delimiter = ' ')

a = []
for row in csv_reader:
    a.append(row)

print "csv file name is", csv_name
print "'a' is array readed form csv file"
