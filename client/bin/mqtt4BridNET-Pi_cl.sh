#!/usr/bin/env bash
#~/BirdNET-Pi/birdnet/bin/pip3 install paho-mqtt
source /etc/birdnet/birdnet.conf
set -x
#todo: 
# sudo chown pew:pew apprise.txt
# leere datei OK
# bei marker austauschen
mv $HOME/BirdNET-Pi/apprise.txt $HOME/BirdNET-Pi/apprise.txt.old
cp $HOME/BirdNET-Pi/birdnet.conf $HOME/BirdNET-Pi/birdnet.conf.old

MQTT_BROCKER=test.mosquitto.org
DATABASE=birdnet-pi_cl
DBTABLE=`getmac -i eth0`
MARKER="\t\t# BirdNET-Pi_cl"
echo "mqtt://$MQTT_BROCKER/$DATABASE/$DBTABLE $MARKER" > $HOME/BirdNET-Pi/apprise.txt



NEW_ROW="APPRISE_NOTIFICATION_BODY='{\"sciname\":\"\$sciname\",\"comname\":\"\$comname\",\"confidence\":\"\$confidence\",\"lat\":\"\$latitude\",\"lng\":\"\$longitude\",\"dt\":\"\$date \$time\",\"week\":\"\$week\",\"sens\":\"\$sens\",\"cutoff\":\"\$cutoff\",\"overlap\":\"\$overlap\"}'"

awk -v new_row="$NEW_ROW" ' \
	{
	if (substr($0,1,25) == "APPRISE_NOTIFICATION_BODY")  {print new_row } \
	else if (substr($0,1,29) == "APPRISE_NOTIFY_EACH_DETECTION") {print "APPRISE_NOTIFY_EACH_DETECTION=1" } \
	else {print $0} \
	} \
' $HOME/BirdNET-Pi/birdnet.conf.old > $HOME/BirdNET-Pi/birdnet.conf


$HOME/BirdNET-Pi/scripts/restart_services.sh
