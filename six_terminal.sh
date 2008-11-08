#!/bin/bash
style=( alter0 alter1 alter2 alter3 alter4 alter5 alter6 alter7 )
num=8
i=`expr $RANDOM`
gnome-terminal --geometry=155x24+0+0   --window-with-profile=${style[`expr $i % $num`]} --working-directory=$1
i=`expr $i + 1`
gnome-terminal --geometry=155x24+0+440 --window-with-profile=${style[`expr $i % $num`]} --working-directory=$1
i=`expr $i + 1`
gnome-terminal --geometry=155x24+0+830 --window-with-profile=${style[`expr $i % $num`]} --working-directory=$1
i=`expr $i + 1`
gnome-terminal --geometry=155x24+960+0   --window-with-profile=${style[`expr $i % $num`]} --working-directory=$1
i=`expr $i + 1`
gnome-terminal --geometry=155x24+960+440 --window-with-profile=${style[`expr $i % $num`]} --working-directory=$1
i=`expr $i + 1`
gnome-terminal --geometry=155x24+960+830 --window-with-profile=${style[`expr $i % $num`]} --working-directory=$1
