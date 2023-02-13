#!/usr/bin/env bash

#
# sends an MQTT 'Bird' messsage to the BirdNET-Pi_cluster for testing
#

# read configuration
[ -f /etc/birdnet/birdnet.conf ] && source /etc/birdnet/birdnet.conf
[ -f /etc/birdnet/birdnet_pi_cluster.conf ] && source /etc/birdnet/birdnet_pi_cluster.conf
#sudo apt install mosquitto-clients
set -x
MAC_ADRESS=`./getMacAdress.sh`

mosquitto_sub -h $MQTT_BROKER  -t "birdnet_pi_cluster/birds/json_v2/$MAC_ADRESS" -v -C 1 &
mosquitto_sub -h $MQTT_BROKER  -t "birdnet_pi_cluster/health/json_v2/$MAC_ADRESS/#" -v -C 1 &
mosquitto_sub -h $MQTT_BROKER  -t "birdnet_pi_cluster/health/influx/$MAC_ADRESS/#" -v -C 1 &

wait
echo "fertig"
