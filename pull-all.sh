#!/bin/bash

cwd=`pwd`
for dirpath in "$@"
do
    if [ -d $dirpath ]; then
	echo "Change dir to $dirpath"
	cd $dirpath
	if   [ -e .svn ]; then svn update
	elif [ -e .git ]; then git pull
	elif [ -e .hg  ]; then hg  pull
	else
	    echo "$dirpath is not a repository. Ignore this."
	    echo
	fi
	
	if [ $? != 0 ]; then
	    echo "Error while updating $dirpath"
	    exit $?
	fi

	echo "Back to $cwd"
	cd $cwd
	echo
    else
	echo "$dirpath is not a directory. Ignore this."
	echo
    fi
done
