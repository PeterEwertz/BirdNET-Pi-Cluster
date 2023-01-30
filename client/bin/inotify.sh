#!/usr/bin/env bash
#sudo apt install inotify-tools


set -x
[ -f /etc/birdnet/birdnet.conf ] && source /etc/birdnet/birdnet.conf
[ -z $RECS_DIR ] && RECS_DIR=/tmo/ino  # Testconfiguration if not set

sox2json() {
#  Format sox output to json
	sox  $1 -n stat 2>&1  |\
	awk -v anzahl=15 -F':' '
		BEGIN { printf ("%s", "{") }
		function ltrim(s) { sub(/^[ \t\r\n]+/, "", s); return s }
		function rtrim(s) { sub(/[ \t\r\n]+$/, "", s); return s }
		function trim(s)  { return rtrim(ltrim(s)); }
		{
			gsub(/ +/, "_", $1)
			if ( NR != anzahl ) {
				printf ("\"%s\":%s,", trim($1), trim($2))
			} else {
				printf ("\"%s\":%s",  trim($1), trim($2))
			}
		}
		END { printf ("%s", "}") } 
	'
}

inotifywait -m $RECS_DIR -e create |
    while read DIR ACTION FILE; do
	if [ -f $DIR$FILE ]; then
        	#echo "The FILE '$FILE' appeared in directory '$DIR' via '$ACTION'"
        	## do something with the FILE
		#echo "sox $DIR$FILE -n stat"

		PLAYGROUND=`sox2json "$DIR$FILE" -n stat | tr -d '\n' `
		mosquitto_pub -h 49.12.4.122 -t "birdnet_pi_cl/1c:69:7a:64:82:c7/sox-n" -m "$PLAYGROUND"
	fi
    done
