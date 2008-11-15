#!/bin/bash
i0=10
num=6
i1=`expr $i0 + $num - 1`

if [ "$1" == "" ]; then
    echo "need dir name"
    exit 1
else
    dir=$1
fi

for i in `seq $i0 $i1`
do
    echo "screen -t tks $i ~/mybin/ssh_qsub.sh -d takafumi_single -r $dir zsh"
    screen -t tks $i ~/mybin/ssh_qsub.sh -d takafumi_single -r $dir zsh
done
