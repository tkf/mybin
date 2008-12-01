#!/bin/sh

src=$1
shift
echo $@

for trg in "$@"
do
  cp $src $trg -v
done
