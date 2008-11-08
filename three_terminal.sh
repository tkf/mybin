#!/bin/bash
style=( alter0 alter1 alter2 alter3 alter4 )
gnome-terminal --geometry=315x24+0+0   --window-with-profile=${style[`expr $RANDOM % 5`]} --working-directory=$1
gnome-terminal --geometry=315x24+0+440 --window-with-profile=${style[`expr $RANDOM % 5`]} --working-directory=$1
gnome-terminal --geometry=315x24+0+830 --window-with-profile=${style[`expr $RANDOM % 5`]} --working-directory=$1
