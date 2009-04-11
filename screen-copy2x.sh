#!/bin/sh

TMP=/tmp/screen-clipboard.`who am i | awk '{print $1}'`

screen -X writebuf -e UTF-8 ${TMP}
xclip ${TMP} -selection primary
xclip ${TMP} -selection clipboard
screen -X eval "echo \"buffer send to X clipboard\"" 
