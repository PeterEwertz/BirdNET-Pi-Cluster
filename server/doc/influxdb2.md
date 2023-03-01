echo "deb https://repos.influxdata.com/ubuntu focal stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
sudo curl -sL https://repos.influxdata.com/influxdb.key | sudo apt-key add -
sudo apt-get install influxdb
mosquitto_sub -t "birdnet_pi_cluster/health/influx/#" -v
mosquitto_sub -t "birdnet_pi_cluster/health/influx/+/sox-n" -v
mosquitto_sub -t "birdnet_pi_cluster/health/influx/'" -v
mosquitto_sub -t "birdnet_pi_cluster/health/influx/#" -v
wget -q https://repos.influxdata.com/influxdata-archive_compat.key
gpg --with-fingerprint --show-keys ./influxdata-archive_compat.key
gpg --with-fingerprint --show-keys ./influxdata-archive_compat.key
cat influxdata-archive_compat.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg > /dev/null
echo 'deb [signed-by=/etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg] https://repos.influxdata.com/debian stable main' | sudo tee /etc/apt/sources.list.d/influxdata.list
echo 'deb [signed-by=/etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg] https://repos.influxdata.com/debian stable main' | sudo tee /etc/apt/sources.list.d/influxdata.list
sudo rm /etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg 
echo "deb https://repos.influxdata.com/ubuntu focal stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
sudo curl -sL https://repos.influxdata.com/influxdb.key | sudo apt-key add -
cat /etc/apt/sources.list.d/influxdb.list 
sudo curl -sL https://repos.influxdata.com/influxdb.key
sudo curl -sL https://repos.influxdata.com/influxdb.key | sudo apt-key add -
sudo curl -sL https://repos.influxdata.com/influxdb.key | sudo apt-key add -
sudo curl -sL https://repos.influxdata.com/influxdb.key | less
wget -q -O key.gpg  https://repos.influxdata.com
wget -q -O key.gpg https://repos.influxdata.com/influxdb.key
gpg --no-default-keyring --keyring ./tmp.gpg --export --output influxdb.gpg
sudo mv influxdb.gpg /usr/local/share/keyrings
cat influxdb.list 
sudo vi influxdb.list 
cat influxdb.list 
mv influxdata.list influxdata.list.old
sudo mv influxdata.list influxdata.list.old
rm influxdata.list.old 
sudo rm influxdata.list.old 
wget -nc https://repos.influxdata.com/influxdb.key
cat influxdb.key |gpg --dearmor | sudo tee /usr/share/keyrings/influxdb.key > /dev/null 2>&1 
cat influxdb.key |gpg --dearmor | sudo tee /usr/share/keyrings/influxdb.gpg > /dev/null 2>&1 
sudo rm /usr/share/keyrings/influxdb.key 
cat /etc/apt/sources.list.d/influxdb.list 
ls -l /usr/local/share/keyrings/influxdb.gpg
sudo vi /etc/apt/sources.list.d/influxdb.list 
mosquitto_sub -t "birdnet_pi_cluster/+/influx/#" -v
rm key.gpg influxdb.key* trusted.gpg 
wget -q https://repos.influxdata.com/influxdata-archive_compat.key
gpg --with-fingerprint --show-keys ./influxdata-archive_compat.key
cat influxdata-archive_compat.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg > /dev/null
echo 'deb [signed-by=/etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg] https://repos.influxdata.com/debian stable main' | sudo tee /etc/apt/sources.list.d/influxdata.list
echo 'deb [signed-by=/etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg] https://repos.influxdata.com/debian stable main' | sudo tee /etc/apt/sources.list.d/influxdata.list
sudo rm -f /etc/apt/trusted.gpg.d/influxdb.gpg
sudo rm -f /etc/apt/trusted.gpg.d/influxdb.gpg
sudo vi /etc/apt/sources.list.d/influxdata.list
sudo vi /etc/apt/sources.list.d/influxdata.list
locate influxdb.gpg 
sudo rm influxdb*
sudo rm influxdb.gpg~ 
locate influxdb.gpg
sudo rm influxdb.gpg*
locate influxdb.gpg
locate influxd
locate influxd*gpg
locate influxd.*gpg
grep -ir influxdata *
cat sources.list.d/influxdb.list
sudo rm sources.list.d/influxdb.list




sudo apt install influxdb2
sudo service influxdb start


On the public Internet, please use a secure password 
influx setup -u bird_health -p bird_health -o bird_health -b bird_health -f 

set `cat .influxdbv2/configs|grep -v "^ *#" | grep "token" `
echo "INFLUX_TOKEN=$3"|sudo tee -a /etc/default/telegraf


influx v1 dbrp create --db bird_health-db --rp bird_health-rp --bucket-id ca304a74b185ec80   --default


influx user create --name grafana --password grafana
