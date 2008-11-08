#!/bin/sh
tmp_file=`mktemp` || exit 1
last=`expr $2 - 1`

echo "only" >> $tmp_file

for i in `seq $1 $last`
do
    echo "split" >> $tmp_file
done

echo "focus top" >> $tmp_file

for i in `seq $1 $2`
do
    echo "select ${i}" >> $tmp_file
    echo "focus down" >> $tmp_file
done

#cat $tmp_file
#echo $tmp_file
screen -X source $tmp_file

rm -f $tmp_file
