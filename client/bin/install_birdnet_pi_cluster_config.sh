#!/usr/bin/env bash
# Creates and installs the /etc/birdnet/birdnet_pi_cluster.conf file
set -x 
set -e
trap 'exit 1' SIGINT SIGHUP

echo "Beginning $0"
birdnet_pi_cluster_conf=$my_dir/birdnet_pi_cluster.conf

install_config() {
  mac_adress=`$my_dir/bin/getMacAdress.sh`
  cat << EOF > $birdnet_pi_cluster_conf
################################################################################
#                    Configuration settings for BirdNET-Pi_cluster             #
################################################################################

# MQTT_BROCKER is the internet address of the server that will receive         #
# the bird detections and the health data from the BirdNET-Pi station.         #
MQTT_BROCKER="49.12.4.122"

# MAC_ADDRESS is the MAC address of the RJ45 interface. It is unique worldwide #
# and is used to identify the BirdNET Pi station on the server.
MAC_ADRESS="$mac_adress"
EOF
}

# Checks for a birdnet_pi_cluster.conf file
if ! [ -f ${birdnet_pi_cluster_conf} ];then
  install_config
fi
chmod g+w ${birdnet_pi_cluster_conf}
[ -d /etc/birdnet ] || sudo mkdir /etc/birdnet
sudo ln -sf $birdnet_pi_cluster_conf /etc/birdnet/birdnet_pi_cluster.conf
grep -ve '^#' -e '^$' /etc/birdnet/birdnet.conf > $my_dir/firstrun.ini
