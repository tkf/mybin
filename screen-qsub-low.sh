#!/bin/sh
i0=20
num=10
i1=`expr $i0 + $num - 1`

dir=$1

for i in `seq $i0 $i1`
do
    echo "screen -t low $i ~/mybin/ssh_qsub.sh -d low -r $dir zsh"
    screen -t low $i ~/mybin/ssh_qsub.sh -d low -r $dir zsh
done
