#!/bin/sh
host=yoganidra
dest=takafumi_single
dir="~"

CMDNAME=`basename $0`
HELP="
Usage: $CMDNAME [-s host] [-d dest] [-r dir] [cmd]\n
host \t ssh to this host. [$host] \n
dest \t qsub to this destination. [$dest] \n
dir \t after qsub, change dirctory to here. [$dir] \n
cmd \t additional command\n
"

while getopts s:d:r:h OPT
do
  case $OPT in
    "s" ) flg_host="TRUE" ; host="$OPTARG" ;;
    "d" ) flg_dest="TRUE" ; dest="$OPTARG" ;;
    "r" )  flg_dir="TRUE" ;  dir="$OPTARG" ;;
    "h" ) echo $HELP 1>&2
          exit 1 ;;
      * ) echo $HELP 1>&2
          exit 1 ;;
  esac
done

shift `expr $OPTIND - 1`

# login to host($1), qsub with "-q $2", change to dir $3,
# execute additional command, and wait for stdin
ept_ssh_qsub(){
    expect -c '
set prompt "(%|#|\\$) "
set timeout 20
spawn ssh '$1'
expect -re $prompt ; send "qsub -I -l nodes=1:ppn=1 -q '$2'\r"
expect "ready"
expect -re $prompt ; send "cd '$3'\r"
expect -re $prompt ; send "'$4'\r"
interact
'
}

echo "host = $host"
echo "dest = $dest"
echo "dir  = $dir"
echo "cmd  = $@"

ept_ssh_qsub $host $dest $dir "$@"
