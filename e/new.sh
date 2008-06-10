
for i in `seq -w 500`
do
#echo -n $1$i.mdwn
if [ ! -e $1$i.mdwn ] ;then
	echo $1$i.mdwn did not exist
	echo '[[meta title="TITLE"]]' > $1$i.mdwn
	vim $1$i.mdwn
	exit
fi
done
