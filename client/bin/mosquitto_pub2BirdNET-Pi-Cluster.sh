#!/usr/bin/env bash

#
# sends an MQTT 'Bird' messsage to the BirdNET-Pi_cluster for testing
#

# read configuration
[ -f /etc/birdnet/birdnet.conf ] && source /etc/birdnet/birdnet.conf
[ -f /etc/birdnet/birdnet_pi_cluster.conf ] && source /etc/birdnet/birdnet_pi_cluster.conf
#sudo apt install mosquitto-clients
set -x
# json_v2
mosquitto_pub -h $MQTT_BROKER  -t "birdnet_pi_cluster/birds/json_v2/$MAC_ADRESS" -m "{\"host\":\"$MAC_ADRESS\",\"sciname\":\"TEST\",\"comname\":\"TEST\",\"confidence\":\"0.9724654\",\"lat\":\"48.15\",\"lng\":\"11.5833\",\"dt\":\"1955-08-12 19:42:40\",\"week\":\"30\",\"sens\":\"1.25\",\"cutoff\":\"0.7\",\"overlap\":\"0.0\"}"

## mosquitto_pub -h $MQTT_BROKER  -t "birdnet_pi_cluster/birds/json_v2/$MAC_ADRESS" \
## -m "\
## {\
##     "time": 1555745371410, \
##     "measurements": [\
##         {\
##             "name": "temperature",\
##             "value": 23.4,\
##             "units": "℃"\
##         },\
##         {\
##             "name": "moisture",\
##             "value": 5,\
##             "units": "%"\
##         },\
##         {\
##             "name": "light",\
##             "value": 10118,\
##             "units": "lux"\
##         },\
##         {\
##             "name": "fertility",\
##             "value": 0,\
##             "units": "us/cm"\
##         }\
##     ]\
## }\
## "
#-m "{measurements:[name:birds-x{host:$MAC_ADRESS},{sciname:TEST1}]}"
#-m "{\"measurements\":[\"name\":\"birds-x\"\"host\":\"$MAC_ADRESS\",\"sciname\":\"TEST1\",\"comname\":\"TEST1\",\"confidence\":\"0.9724654\",\"lat\":\"48.15\",\"lng\":\"11.5833\",\"dt\":\"1955-08-12 19:42:40\",\"week\":\"30\",\"sens\":\"1.25\",\"cutoff\":\"0.7\",\"overlap\":\"0.0\"]}"

#line-protocol
#mosquitto_pub -h $MQTT_BROKER  -t "birdnet_pi_cluster/birds/DE/NRW/Krefeld" \
#-m "birds6,host=$MAC_ADRESS,sciname=sciTEST1,comname=comTEST1 confidence=0.9724654,lat=48.15,lng=11.5833,dt=\"1955-08-12 19:42:40\",sens=1.25,cutoff=0.7,overlap=0.0"
# mit fester Zeit
#mosquitto_pub -h $MQTT_BROKER  -t "birdnet_pi_cluster/birds/DE/NRW/Krefeld" \
#-m "birds6,host=$MAC_ADRESS,sciname=sciTEST1,comname=comTEST1 confidence=0.9724654,lat=48.15,lng=11.5833,dt=\"1955-08-12 19:42:40\",sens=1.25,cutoff=0.7,overlap=0.0"

