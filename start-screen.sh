#!/bin/sh
myname=`whoami`
screenid=`ls -1 --color=never /var/run/screen/S-$myname | head -n1`
screenexist=`echo $screenid | wc -c`

echo $screenid
if [ $screenexist -gt 1 ]; then
    # if there is at least one screen session.
    screen -x $screenid
 else
    screen
fi
