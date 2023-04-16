wget -q https://repos.influxdata.com/influxdata-archive_compat.key
gpg --with-fingerprint --show-keys ./influxdata-archive_compat.key
cat influxdata-archive_compat.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg > /dev/null
echo 'deb [signed-by=/etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg] https://repos.influxdata.com/debian stable main' | sudo tee /etc/apt/sources.list.d/influxdata.list
echo 'deb [signed-by=/etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg] https://repos.influxdata.com/debian stable main' | sudo tee /etc/apt/sources.list.d/influxdata.list

sudo apt update

sudo apt install influxdb2

On the public Internet, please use a secure password 
influx setup -u birds-user -p password -o birds-org -b birds-bucket -f 

set `cat .influxdbv2/configs|grep -v "^ *#" | grep "token" `
echo "INFLUX_TOKEN=$3"|sudo tee -a /etc/default/telegraf

influx config create -n basic-config -u http://localhost:8086  -p pew:wlctf%32 -o birds-org


influx org create --name birds-org
influx bucket create --org birds-org --name birds-bucket





influx user create --name grafana --password grafana_password
influx v1 auth create --org birds-org --username grafana --password grafana_password --read-bucket 89b51e7a166ba727
influx v1 dbrp create --org birds-org --bucket-id 89b51e7a166ba727 --db birds-dbrp --rp autogen



debug:
sudo vi /etc/influxdb/config.toml
sudo systemctl stop telegraf
