#!/bin/sh

TMP=/tmp/screen-clipboard.`whoami | awk '{print $1}'`

screen -X writebuf ${TMP}
xclip ${TMP} -selection primary
xclip ${TMP} -selection clipboard
screen -X eval "echo \"buffer send to X clipboard\"" 
