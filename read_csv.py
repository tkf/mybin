#!/usr/bin/env python

import sys
import csv

csv_name=sys.argv[1]
csv_reader=csv.reader(open(csv_name))

a = []
for row in csv_reader:
    a.append(row)

print "csv file name is", csv_name
print "'a' is array readed form csv file"
