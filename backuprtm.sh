#!/bin/sh

download_rtm(){
    id=$1
    pw=$2
    backup_path=$3
    interval=$4
    ical=rememberthemilk.ical
    events=rememberthemilk.events.ical

    cd $backup_path
    while [ 1 ]
    do
	wget -O $ical -o ${ical}.log --http-user=$id --http-passwd=$pw \
	    https://www.rememberthemilk.com/icalendar/$id/
	wget -O $events -o ${events}.log --http-user=$id --http-passwd=$pw \
	    https://www.rememberthemilk.com/icalendar/$id/events/
	sleep $interval
    done
}

# default options
rtm_id=""
backup_path="${HOME}/backup/"
interval="3h"

# set options
CMDNAME=`basename $0`
HELP="
Usage: $CMDNAME [options]\n
-i : RTM id\n
-b : backup path (default: $backup_path)\n
-s : backup interval (default: $interval)\n
-d : as daemon\n
-h : help\n
"

while getopts i:b:s:dh OPT
do
    case $OPT in
	"i" ) flg_i="TRUE" ; rtm_id="$OPTARG" ;;
	"b" ) flg_b="TRUE" ; backup_path="$OPTARG" ;;
	"s" ) flg_s="TRUE" ; interval="$OPTARG" ;;
	"d" ) flg_d="TRUE" ;;
	"h" ) echo $HELP 1>&2
            exit 1 ;;
	* ) echo $HELP 1>&2
            exit 1 ;;
    esac
done

echo "Password: \c"
stty -echo
read rtm_pw
stty echo

if [ "$flg_d" = "TRUE" ]
then
    (download_rtm $rtm_id $rtm_pw $backup_path $interval &)
else
    download_rtm $rtm_id $rtm_pw $backup_path $interval
fi
