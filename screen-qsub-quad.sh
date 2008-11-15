#!/bin/bash
i0=22
num=1
i1=`expr $i0 + $num - 1`

if [ "$1" == "" ]; then
    echo "need dir name"
    exit 1
else
    dir=$1
fi

for i in `seq $i0 $i1`
do
    echo "screen -t quad $i ~/mybin/ssh_qsub.sh -d student_quad -p 4 -r $dir zsh"
    screen -t quad $i ~/mybin/ssh_qsub.sh -d student_quad -p 4 -r $dir zsh
done
