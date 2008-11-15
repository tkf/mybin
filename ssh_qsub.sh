#!/bin/sh
host=yoganidra
dest=takafumi_single
dir="~"
ppn=1

CMDNAME=`basename $0`
HELP="
Usage: $CMDNAME [-s host] [-d dest] [-r dir] [cmd]\n
host \t ssh to this host. [$host] \n
dest \t qsub to this destination. [$dest] \n
ppn \t qsub -l nodes=1:ppn=HERE. [$ppn] \n
dir \t after qsub, change dirctory to here. [$dir] \n
cmd \t additional command\n
"

while getopts s:d:r:p:h OPT
do
  case $OPT in
    "s" ) flg_host="TRUE" ; host="$OPTARG" ;;
    "d" ) flg_dest="TRUE" ; dest="$OPTARG" ;;
    "r" )  flg_dir="TRUE" ;  dir="$OPTARG" ;;
    "p" )  flg_ppn="TRUE" ;  ppn="$OPTARG" ;;
    "h" ) echo $HELP 1>&2
          exit 1 ;;
      * ) echo $HELP 1>&2
          exit 1 ;;
  esac
done

shift `expr $OPTIND - 1`

# login to host($1), qsub with "-q $2 -l nodes=1:ppn=$3",
# change to dir $4, 
# execute additional command $5, and wait for stdin
ept_ssh_qsub(){
    expect -c '
set prompt "(%|#|\\$) "
set timeout 20
spawn ssh '$1'
expect -re $prompt ; send "qsub -I -l nodes=1:ppn='$3' -q '$2' \r"
expect "ready"
expect -re $prompt ; send "cd '$4'\r"
expect -re $prompt ; send "'$5'\r"
interact
'
}

echo "host = $host"
echo "dest = $dest"
echo "dir  = $dir"
echo "ppn  = $ppn"
echo "cmd  = $@"

ept_ssh_qsub $host $dest $ppn $dir "$@"
