#!/bin/bash
set -x
SERVERDIR="birdnet-pi_cluster/server"

cp $HOME/$SERVERDIR/etc/telegraf/telegraf.d/io_pg_birdnet-pi_cl.conf /etc/telegraf/telegraf.d/io_pg_birdnet-pi_cl.conf 
#sudo service telegraf enable
sudo service telegraf restart
