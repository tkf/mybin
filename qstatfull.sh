#!/bin/bash
id_list=`qstat | grep "[0-9]*.yoganidra" -o`
for id in $id_list
do
  job_name=$(qstat -f1 $id | grep -oE "\-o +[^ ]* ")
  info=$(qstat $id |tail -n 1 |sed -e 's/ [^0-9a-zA-Z][0-9a-zA-Z\._=]\+ *[^0-9a-zA-Z][0-9a-zA-Z\._=]\+//' | sed -e 's/takafumi_single/t_s/')
  echo $info$'\t'${job_name:3}
done