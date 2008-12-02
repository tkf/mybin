#!/bin/sh
tmp_file=`mktemp` || exit 1
cmd=$1
start=$2
last=$3

for i in `seq ${start} ${last}`
do
    echo "select ${i}" >> $tmp_file
    echo "stuff '${cmd}'" >> $tmp_file
    echo "stuff \\015" >> $tmp_file
done

#cat $tmp_file
#echo $tmp_file
screen -X source $tmp_file

rm -f $tmp_file
