#!/bin/sh
#
BakDir=""
Yesterday=$(date -d 'yesterday' +%Y%m%d)
LogDir="../lib/bts.$Yesterday.*.log"

if [ ! -d $BakDir ]
then
    mkdir $BakDir
fi

tar -zcvf $BakDir/bts.$Yesterday.tar.gz $LogDir

rm $LogDir
