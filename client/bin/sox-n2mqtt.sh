#!/usr/bin/env bash

#
# examines every new incoming file under $PROCESSED, with "sox filename -n stat"
#

#set -x
# read configuration
[ -f /etc/birdnet/birdnet.conf ] && source /etc/birdnet/birdnet.conf
[ -f /etc/birdnet/birdnet_pi_cluster.conf ] && source /etc/birdnet/birdnet_pi_cluster.conf

# Testconfiguration if not set
[ -z "$PROCESSED" ] && PROCESSED=/tmp/ino
[ -z "$MQTT_BROKER" ] && MQTT_BROKER="birdnet-pi-cluster.net"
[ -z "$MAC_ADRESS" ] && MAC_ADRESS="FF:FF:FF:FF:FF:FF"
[ -z "$TOPIC_PRE" ] && TOPIC_PRE="birdnet_pi_cluster/test"
# run for test: 'while true; do cp /usr/share/sounds/alsa/Rear_Center.wav /tmp/ino/`date +%s`.wav; sleep 10; done'
#
sox2json() {
#  Format sox output to json
	# "number=15": because sox -n returns 15 lines
	sox  $1 -n stat 2>&1  |\
	awk -v mac_adress=$MAC_ADRESS -F':' '
		function replace_blank(s) { gsub(/([[:blank:]]+)/, "_", s); return s }
		function trim_space(s) { gsub(/[ ]/, "", s); return s }
		function trim_bracket(s) { gsub(/[(]|[)]/, "", s); return s }
		function build_name(s) { s = tolower(trim_bracket(replace_blank(s))); return s }
		BEGIN { 
			local_time = sprintf("local_time=\"%s\"", strftime("%FT%T%z", systime()))
			playground = sprintf("sox-n host=\"%s\",%s", mac_adress, local_time)
		}
		{
			playground = sprintf("%s,%s=%s", playground, build_name($1), trim_space($2))
		}
		END {
		print (playground)
		}
	' 
}

inotifywait -m $PROCESSED -e create,moved_to --exclude '.*.csv' |
    while read DIR ACTION FILE; do
	if [ -f $DIR$FILE ]; then
        	#echo "The FILE '$FILE' appeared in directory '$DIR' via '$ACTION'"
        	## do something with the FILE
		#echo "sox $DIR$FILE -n stat"

		PLAYGROUND=`sox2json "$DIR$FILE" -n stat | tr -d '\n' `
		mosquitto_pub -h $MQTT_BROKER -t "$TOPIC_PRE/health/influx/$MAC_ADRESS/sox-n" -m "$PLAYGROUND"
	fi
    done
### test:
##		PLAYGROUND=`sox2json /usr/share/sounds/alsa/Rear_Center.wav -n stat`
##		echo mosquitto_pub -h $MQTT_BROKER -t "$TOPIC_PRE/health/influx/$MAC_ADRESS/sox-n" -m "$PLAYGROUND"
##		echo -e $PLAYGROUND
##		mosquitto_pub -h $MQTT_BROKER -t "$TOPIC_PRE/health/influx/$MAC_ADRESS/sox-n" -m "$PLAYGROUND"
