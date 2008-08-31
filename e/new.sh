#!/bin/sh
TIPS=../tips.mdwn
grep -l TITLE *.mdwn | xargs rm

if test -z $1
then
	cat $TIPS
	exit
fi

grep -B 1 $1 $TIPS
sleep 1
for i in `seq -w 500`
do
if [ ! -e $1$i.mdwn ] ;then
	echo $1$i.mdwn did not exist
	echo '[[meta title="TITLE"]]' > $1$i.mdwn
	vim $1$i.mdwn
	exit
fi
done
