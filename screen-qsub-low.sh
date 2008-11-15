#!/bin/bash
i0=30
num=10
i1=`expr $i0 + $num - 1`

if [ "$1" == "" ]; then
    echo "need dir name"
    exit 1
else
    dir=$1
fi

for i in `seq $i0 $i1`
do
    echo "screen -t low $i ~/mybin/ssh_qsub.sh -d low -r $dir zsh"
    screen -t low $i ~/mybin/ssh_qsub.sh -d low -r $dir zsh
done
