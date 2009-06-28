#!/bin/sh

COLLECT_PAH=$HOME/Dropbox/linux/collection

new=${COLLECT_PAH}/`date +%F-%T`-`basename $1`
cp $1 $new
echo "copy to $new"
