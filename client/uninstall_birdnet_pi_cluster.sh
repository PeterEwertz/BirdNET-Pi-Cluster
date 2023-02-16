#!/usr/bin/env bash
# Uninstall script to remove everything
set -x # Uncomment to debug
trap 'rm -f ${TMPFILE}' EXIT
my_dir=$HOME/birdnet_pi_cluster/client/bin
SCRIPTS=($(ls -1 ${my_dir}))
services=($(awk '/service/ && /systemctl/ && /enable/ {print $3}' ${my_dir}/install_birdnet_pi_cluster_services.sh | sort))

remove_services() {
  for i in "${services[@]}"; do
    if [ -L /etc/systemd/system/multi-user.target.wants/"${i}" ];then
      sudo systemctl disable --now "${i}"
    fi
    if [ -L /lib/systemd/system/"${i}" ];then
      sudo rm -f /lib/systemd/system/$i
    fi
    if [ -f /etc/systemd/system/"${i}" ];then
      sudo rm /etc/systemd/system/"${i}"
    fi
    if [ -d /etc/systemd/system/"${i}" ];then
      sudo rm -drf /etc/systemd/system/"${i}"
    fi
  done
  set +x
}



remove_scripts() {
  for i in "${SCRIPTS[@]}";do
    if [ -L "/usr/local/bin/${i}" ];then
      sudo rm -v "/usr/local/bin/${i}"
    fi
  done
}

reset_telegraf() {
      sudo systemctl disable --now telegraf
      sudo telegraf config > /tmp/telegraf.conf
      sudo mv /tmp/telegraf.conf /etc/telegraf/telegraf.conf
      sudo rm -f /etc/telegraf/telegraf.d/*birdnet_pi_cluster*.conf
}

reset_telegraf
remove_services
remove_scripts
if [ -f /etc/birdnet/birdnet_pi_cluster.conf ];then sudo rm -f /etc/birdnet/birdnet_pi_cluster.conf ;fi
if [ -f ${HOME}/birdnet_pi_cluster/client/birdnet_pi_cluster.conf ];then sudo rm -f ${HOME}/birdnet_pi_cluster/client/birdnet_pi_cluster.conf ;fi

cd $HOME
echo "Uninstall finished. Remove this directory with 'rm -drfv $HOME/birdnet_pi_cluster' to finish."
