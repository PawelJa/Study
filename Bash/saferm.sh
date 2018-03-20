#!/bin/bash
KOSZ=~/KOSZ
ARG=$1
echo $ARG
echo $KOSZ
if [ -d $KOSZ ]
	then
		echo "istnieje"
	else 
		mkdir ~/KOSZ
fi

SPR=$KOSZ/$ARG

if [ -e $SPR.xz ]
	then
		xz -d $SPR.xz
		mv $SPR `cat $SPR.txt`
		rm $SPR.txt
	else
		if [ -f $ARG ];	then
				echo "plik"
				pwd > ~/KOSZ/$ARG.txt
				xz -z $ARG
				mv $ARG.xz $KOSZ;
			
			elif [ -d $ARG ]; then
				echo "katalog"
			elif [ -L $ARG ]; then
				echo "dowiazanie"
			else
				echo "ups to nie jest ani plik, ani katalog, ani dowiązanie"
		fi

fi

	

