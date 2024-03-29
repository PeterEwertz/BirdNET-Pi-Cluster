#!/usr/bin/env bash
# Install BirdNET script
set -x # Debugging
exec > >(tee -i installation-BirdNET-Pi-Cluster-$(date +%F).txt) 2>&1 # Make log
set -e # exit installation if anything fails

my_dir=$HOME/BirdNET-Pi-Cluster/client
export my_dir=$my_dir

if [ -e /etc/birdnet/birdnet.conf ]; then
	source /etc/birdnet/birdnet.conf
else
	echo "no BirNET-Pi configuration found"
	exit 1
fi

cd $my_dir || exit 1


#Install/Configure /etc/birdnet/birdnet_pi_cluster.conf
./bin/install_BirdNET-Pi-Cluster_config.sh || exit 1

sudo -E HOME=$HOME USER=$USER ./bin/install_BirdNET-Pi-Cluster_services.sh || exit 1
source /etc/birdnet/birdnet_pi_cluster.conf

exit 0
