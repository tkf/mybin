#!/bin/sh

cmd="mv"

CMDNAME=`basename $0`
HELP="
Usage: $CMDNAME [-c cp|mv] [-h]\n
-c : select a command. default is '${cmd}'.\n
-h : help\n
"


while getopts c:h OPT
do
  case $OPT in
    "c" ) flg_c="TRUE" ; cmd="$OPTARG" ;;
    "h" ) echo $HELP 1>&2
          exit 1 ;;
      * ) echo $HELP 1>&2
          exit 1 ;;
  esac
done

# check command
if [ "$cmd" != "cp" -a "$cmd" != "mv" ]; then
    echo "Error : command should be 'mv' or 'cp'."
    echo $HELP
    exit 1
fi

if [ "$cmd" = "cp" ]; then
    cmd="cp -r "
fi

if [ "$cmd" = "mv" ]; then
    cmd="mv -v "
fi

shift `expr $OPTIND - 1`

# take back up
for trg in "$@"
do
    new="${trg}."`date +%F-%H%M%S`".bak"
    echo "make back up : "$new
    $cmd $trg $new
    if [ -d $new  -a  "$cmd" = "mv" ]; then
	mkdir $trg
    fi
done
