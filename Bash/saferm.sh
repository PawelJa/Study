#!/bin/bash
KOSZ=~/KOSZ
ARG=$1
if [ ! -d $KOSZ ]
	then
		mkdir $KOSZ;
	else
		find $KOSZ/ -mtime +7 -exec rm{} \;
fi

SPR=$KOSZ/$ARG

if [ -e $SPR.xz ]
	then
		xz -d $SPR.xz
		mv $SPR `cat $SPR.txt`
		rm $SPR.txt
	elif [ -d $SPR ]
	then
		#mkdir `cat $SPR/$ARG.txt`/$ARG tworzenie katalogu zrodlowego, z ktorego zostaly usuniete pliki
		mv $SPR/*.xz `cat $SPR/$ARG.txt`/$ARG/
		xz -d `cat $SPR/$ARG.txt`/$ARG/*.xz
		rm -rf $SPR
	elif [ -e $SPR-dow.xz ]
	then
		DES=`cat $SPR-dow.txt`
		SOU=`cat $SPR.txt`
		ln -s `cat $SPR-dow.txt` `cat $SPR.txt`/$ARG
	else
		if [ -L $ARG ];	then
				LINK=`pwd`/`ls -l $ARG | sed 's/^.* -> //'`
				echo $LINK > ~/KOSZ/$ARG-dow.txt
				xz -f $ARG
				pwd > ~/KOSZ/$ARG.txt
				mv $ARG.xz $ARG-dow.xz
				mv $ARG-dow.xz $KOSZ;
			elif [ -d $ARG ]; then
				mkdir $KOSZ/$ARG
				pwd > ~/KOSZ/$ARG/$ARG.txt
				xz -z $ARG/*
				mv $ARG/* $KOSZ/$ARG

			elif [ -f $ARG ]; then
				pwd > ~/KOSZ/$ARG.txt
				xz -z $ARG
				mv $ARG.xz $KOSZ;
			else
				echo "ups, to nie jest ani plik, ani katalog, ani dowiązanie"
		fi

fi

	

