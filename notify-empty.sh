#!/bin/bash
iconpath=/usr/share/icons/gnome/22x22/emotes/stock_smiley-15.png
intv='1m'

CMDNAME=`basename $0`
HELP="
Usage: $CMDNAME [-t intv] file \n
notify when 'file' is empty. 'intv' is interval of checking file.
"

while getopts t:d:r:p:h OPT
do
    case $OPT in
	"t" ) flg_intv="TRUE" ; intv="$OPTARG" ;;
	"h" ) echo $HELP 1>&2
            exit 1 ;;
	* ) echo $HELP 1>&2
            exit 1 ;;
    esac
done

shift `expr $OPTIND - 1`
file=${1}

exec 3> >(zenity --notification --window-icon=${iconpath} --listen)

while(true)
do
    echo "tooltip:`head -n1 ${file}`,... `wc ${file}`" >&3
    if [ "`wc -w ${file} | cut -d' ' -f1`" -eq 0 ]
    then
	echo "message:${file} is empty" >&3
	break
    fi
    sleep ${intv}
done

exec 3>&-
