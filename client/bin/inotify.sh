#!/usr/bin/env bash
#sudo apt install inotify-tools


set -x
[ -f /etc/birdnet/birdnet.conf ] && source /etc/birdnet/birdnet.conf
[ -f /etc/birdnet/birdnet-pi-cluster.conf ] && source /etc/birdnet/birdnet-pi-cluster.conf
[ -z $RECS_DIR ] && RECS_DIR=/tmp/ino  # Testconfiguration if not set
[ -z $MQTT_BROKER ] && MQTT_BROKER="49.12.4.122"
[ -z $TOPIC_PRE ] && TOPIC_PRE="birdnet_pi_cl"
[ -z $BPC_PATH ] && BPC_PATH=/home/pew/Dokumente/Projekte/Birds/birdnet-pi_cluster/client/bin

[ -z $MAC_ADRESS ] && MAC_ADRESS=$($BPC_PATH/getMacAdress.sh)

sox2json() {
#  Format sox output to json
	sox  $1 -n stat 2>&1  |\
	awk -v anzahl=15 -v mac_adress=$MAC_ADRESS -F':' '
		function escape_colon(s) { gsub(/:/, "\\:" s); return s }
		BEGIN { 
			printf ("{\"mac_adress\":\"%s\",", escape_colon(mac_adress)) 
			printf ("\"local_time\":\"%s\",", escape_colon(strftime("%FT%T%z", systime())))
		}
		function ltrim(s) { sub(/^[ \t\r\n]+/, "", s); return s }
		function rtrim(s) { sub(/[ \t\r\n]+$/, "", s); return s }
		function trim(s)  { return tolower(rtrim(ltrim(s))); }
		{
			gsub(/ +/, "_", $1)	# replace " " with "_"
			gsub(/\(|\)/, "", $1)	# replace "(" and ")" with nothing
			if ( NR != anzahl ) {
				printf ("\"%s\":%s,", trim($1), trim($2))
			} else {
				printf ("\"%s\":%s",  trim($1), trim($2))
			}
		}
		END { printf ("}") } 
	' 
}

inotifywait -m $RECS_DIR -e create |
    while read DIR ACTION FILE; do
	if [ -f $DIR$FILE ]; then
        	#echo "The FILE '$FILE' appeared in directory '$DIR' via '$ACTION'"
        	## do something with the FILE
		#echo "sox $DIR$FILE -n stat"

		PLAYGROUND=`sox2json "$DIR$FILE" -n stat | tr -d '\n' `
		mosquitto_pub -h $MQTT_BROKER -t "$TOPIC_PRE/health/json_v2/$MAC_ADRESS/sox-n" -m "$PLAYGROUND"
	fi
    done
