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
	elif [ -d $SPR ]
	then
		mkdir `cat $SPR/$ARG.txt`/$ARG
		mv $SPR/*.xz `cat $SPR/$ARG.txt`/$ARG/
		xz -d `cat $SPR/$ARG.txt`/$ARG/*.xz
		rm -rf $SPR
	else
		if [ -f $ARG ];	then
				echo "plik"
				pwd > ~/KOSZ/$ARG.txt
				xz -z $ARG
				mv $ARG.xz $KOSZ;
			
			elif [ -d $ARG ]; then
				mkdir $KOSZ/$ARG
				pwd > ~/KOSZ/$ARG/$ARG.txt
				xz -z $ARG/*
				mv $ARG/* $KOSZ/$ARG
				rmdir $ARG;
			elif [ -L $ARG ]; then
				echo "dowiazanie"
			else
				echo "ups to nie jest ani plik, ani katalog, ani dowiązanie"
		fi

fi

	

