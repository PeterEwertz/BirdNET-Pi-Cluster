#!/usr/bin/env bash
#~/BirdNET-Pi/birdnet/bin/pip3 install paho-mqtt

#
# modify notify BirdNet-Pi configuration for using with BirdNET-Pi-Cluster
#

set -x
# read configuration
[ -f /etc/birdnet/birdnet.conf ] && source /etc/birdnet/birdnet.conf
[ -f /etc/birdnet/birdnet_pi_cluster.conf ] && source /etc/birdnet/birdnet_pi_cluster.conf
# Testconfiguration if not set
[ -z "${MQTT_BROKER}" ] && MQTT_BROKER="birdnet-pi-cluster.net"
[ -z "${MAC_ADRESS}" ] && MAC_ADRESS="FF:FF:FF:FF:FF:FF"
[ -z "${TOPIC_PRE}" ] && TOPIC_PRE="birdnet_pi_cluster/test"
#
MARKER="BirdNET-Pi-Cluster"
APPRISE_TXT="$HOME/BirdNET-Pi/apprise.txt"
BIRDNET_CONF="$HOME/BirdNET-Pi/birdnet.conf"
JSON_BODY="'{\"host\":\""$MAC_ADRESS"\",\"sciname\":\"\$sciname\",\"comname\":\"\$comname\",\"confidence\":\"\$confidence\",\"lat\":\"\$latitude\",\"lng\":\"\$longitude\",\"dt\":\"\$date \$time\",\"week\":\"\$week\",\"sens\":\"\$sens\",\"cutoff\":\"\$cutoff\",\"overlap\":\"\$overlap\"}'"
NEW_BODY="APPRISE_NOTIFICATION_BODY=$JSON_BODY"
MQTT_URL="mqtt://$MQTT_BROKER/$TOPIC_PRE/birds/json_v2/$MAC_ADRESS"
RED='\033[0;31m'
NOCOLOR='\033[0m'


display_notdone() {
	set +x
	echo -e "####################################################################################
A \"Apprise Notifications Configuration\" was found at your BirdNET-Pi. 
Please check!

For using \""$MARKER"\" use:
in \"Apprise Notifications Configuration\" :
<${RED}$MQTT_URL${NOCOLOR}>
in \"Notification Title\" :
<> (${RED}leave it blank${NOCOLOR})
in \"Notification Body\" :
<${RED}$JSON_BODY${NOCOLOR}>

also enable only \"Notify each new detection\"

####################################################################################"
	exit 1
}

change_allowed() {
	MARKER_COUNT=`grep -o "$MARKER" "$1" |wc -l`
	SERVER_COUNT=`grep -o ":\/\/" "$1" |wc -l`

	if [[ -f "$1" && ! -s "$1" ]]; then  	# file exists and is empty
		echo 1				# do it
		return
	fi

	if [ "$SERVER_COUNT" -ne 1 ]; then	# more than 1 sever
		echo 0				# don't do it
		return
	fi

	if [ "$MARKER_COUNT" -ne 1 ]; then	# 0 || n Marker found
		echo 0				# don't do it
		return
	fi

	echo 1
}

save_it() {
	cp "$APPRISE_TXT" "$APPRISE_TXT"."$MARKER".`date --iso-8601=seconds`
	cp "$BIRDNET_CONF" "$BIRDNET_CONF"."$MARKER".`date --iso-8601=seconds`
}

do_it() {
	save_it

	# apprise.txt has ownership caddy:caddy and cannot be modified.
	# Therefore delete, create new ones and adjust access rights - dirty but it works
	sudo rm $APPRISE_TXT
	echo "$MQTT_URL 	# $MARKER" > $APPRISE_TXT
	sudo chown caddy:caddy $APPRISE_TXT

	# apprise settings in birdnet.conf
	eval sed -in 's/APPRISE_NOTIFICATION_BODY.*/"$NEW_BODY"/' $BIRDNET_CONF
	eval sed -in 's/APPRISE_NOTIFICATION_TITLE.*/APPRISE_NOTIFICATION_TITLE=""/' $BIRDNET_CONF
	eval sed -in 's/APPRISE_NOTIFY_EACH_DETECTION.*/APPRISE_NOTIFY_EACH_DETECTION=1/' $BIRDNET_CONF
	eval sed -in 's/APPRISE_NOTIFY_NEW_SPECIES.*/APPRISE_NOTIFY_NEW_SPECIES=0/' $BIRDNET_CONF
	eval sed -in 's/APPRISE_WEEKLY_REPORT.*/APPRISE_WEEKLY_REPORT=0/' $BIRDNET_CONF
	eval sed -in 's/APPRISE_NOTIFY_NEW_SPECIES_EACH_DAY.*/APPRISE_NOTIFY_NEW_SPECIES_EACH_DAY=0/' $BIRDNET_CONF
	eval sed -in 's/APPRISE_MINIMUM_SECONDS_BETWEEN_NOTIFICATIONS_PER_SPECIES.*/APPRISE_MINIMUM_SECONDS_BETWEEN_NOTIFICATIONS_PER_SPECIES=0/' $BIRDNET_CONF


}

[ `change_allowed $APPRISE_TXT` -eq 1 ] && do_it || display_notdone

$HOME/BirdNET-Pi/scripts/restart_services.sh
