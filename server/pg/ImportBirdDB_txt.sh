#!/bin/bash

usage ()
{
        echo ""
        echo "usage: $0 -c CVS-Datei -m MAC-Adress [-d = debug]"
	echo "  CSV-Datei mit voll qualifiziertem Pfad"
	exit 1
}

debug()
{
        [ "$DEBUG" == "yes" ] && echo $1
}


dateitest ()
{
	# vorhanden und nicht leer
	if [ ! -s $1 ] 
	then
		echo "ERROR: Datei leer oder nicht vorhanden" 
		usage 
	fi

	# Datei enhält 11 Spalten
	if [ `awk -F ';' 'BEGIN {RET=0} {if ( NF != 11 ) { RET=1 }} END {print RET}' "$1"` != 0 ] 
	then
		echo "ERROR: Datei falsch (11 Spalten)"
		usage
	fi
	echo "OK: " $1 "wird verarbeitet"
}

while getopts "m:f:hd" OPTION; 
do
	case $OPTION in
        	m)      MAC_ADRESS=$OPTARG             # MAC-Adress
                	debug "MAC_ADRESS: $MAC_ADRESS"
                	;;
        	f)      FILE=$OPTARG   		        # Filename
                	debug "FILE: $FILE"
                	;;
        	d)      DEBUG="yes"
                	set -x
                	;;
	
        	h)      usage; exit 2;;
        	\?)     echo "Unbekannte Option \"-$OPTARG\"."
                	echo $HELP ; exit 3;;
        	:)      echo "Option \"-$OPTARG\" benötigt ein Argument."
                	echo $HELP ; exit 4;;
        	*)      echo "Dies kann eigentlich nicht passiert sein ...\"$OPTION\"... ";;
	esac
done


# gültige MAC-Adresse
if [[ "$MAC_ADRESS" =~ ^([a-fA-F0-9]{2}:){5}[a-fA-F0-9]{2}$ ]]
then
	echo "OK: " "MAC_ADRESS" $MAC_ADRESS 
else
	echo "ERROR: keine oder falsche MAC-Adresse"
	exit 3
fi

# Datei mit 11 Spalten vorhanden
dateitest $FILE

# Import
psql -d birds -v file=$FILE -v mac_adress=$MAC_ADRESS << EOF
	DROP TABLE IF EXISTS stage_0.birddb_import;
	CREATE TABLE stage_0.birddb_import (
		Date text,
		Time text,
		Sci_Name text,
		Com_Name text,
		Confidence text, 
		Lat text,
		Lon text, 
		Cutoff text,
		Week text,
		Sens text,
		Overlap text
	);
	
	COPY stage_0.birddb_import FROM :'file' DELIMITER ';' CSV HEADER;

	ALTER TABLE stage_0.birddb_import 
		ADD COLUMN topic TEXT DEFAULT 'Import from BirdDB.txt '||now(),
		ADD COLUMN host TEXT DEFAULT :'mac_adress';
EOF


