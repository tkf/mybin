#!/bin/sh
i0=10
num=10
i1=`expr $i0 + $num - 1`

dir=$1

for i in `seq $i0 $i1`
do
    echo "screen -t tks $i ~/mybin/ssh_qsub.sh -d takafumi_single -r $dir zsh"
    screen -t tks $i ~/mybin/ssh_qsub.sh -d takafumi_single -r $dir zsh
done
