#!/bin/bash
echo "Tu kantor!"
echo "Aktualne kursy:"

if [ $1 = "-h" -o $1 = "--help" ]
then {
	echo "pomoc";
	}
else {
	KWOTA=$1
	shift;

	WAL1="EUR"
	WAL2="PLN"
	DATA="latest"

	OPTS='f:t:d:'
	LONGOPTS='from,to,data'
	eval set -- $(getopt -o $OPTS --long $LONGOPTS -- $*)
	while true; do
	case $1 in
  		-f|--from)
			WAL1=$2;
			shift
			shift;;
			
		-t|--to)
			WAL2=$2;
			shift
			shift;;
			
		-d|--date)
			DATA=$2;
			shift			
			shift;;
			
  		--)
  			shift
  			break;;
 		
		:)
			echo "Opcja: -$OPTARG wymaga argumentu!" >&2
 		esac
	done

	function pobierzJson {
		local FILE="/tmp/currecny.json"
		curl -s "https://api.fixer.io/$DATA?base=$WAL1" > $FILE

		JSON_DANE=$(cat $FILE)
		}

	pobierzJson
	echo $JSON_DANE | jq
	echo
	echo "##################################"
	echo "Data: $DATA - $(echo $JSON_DANE | jq -r '.date')"
	WALL=".rates.$WAL2"
	echo "$WAL1 => $WAL2"
	echo "kwota: $KWOTA $WAL1"
	KURS="$(echo -e "$(echo $JSON_DANE | jq -r $WALL )")"
	echo "kurs: $KURS"
	wynik=`echo "$KWOTA*$KURS" | bc`
	echo "wynik wymiany: $wynik $WAL2"
	}
fi
	
