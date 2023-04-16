# BirdNET-Pi-Cluster

**BirdNET-Pi-Cluster** is an expansion to the great [**BirdNET-Pi**](https://github.com/mcguirepr89/BirdNET-Pi) project, which birds recognize on their voice and processes at the local level.

**BirdNET-Pi-Cluster** collects the data from several BirdNET-Pi stations for statistical processing.
This makes it possible to make observations about the vitality and diversity of the bird population. Different locations can be compared with one another or with a group of locations and/or viewed over time.

All relevant data is transferred to the **BirdNET-Pi-Cluster** server by the client  via [MQTT](https://mqtt.org/). It is therefore not necessary to open your home network to access from the internet.

## client
The client (your [**BirdNet-Pi**](https://github.com/mcguirepr89/BirdNET-Pi) station) provides the server data on its technical health, base data and the recognitions of birds.
### install:
In the home directory of the BirdNET-Pi user:
```
git clone git@github.com:PeterEwertz/BirdNET_Pi_Cluster.git
cd ~/BirdNET-Pi-Cluster/client
./install_BirdNET-Pi-Cluster.sh
./bin/mqtt4BridNET-Pi-Cluster.sh
```

### data to collect:

#### server health
`telegraf.service` offers the transmission of data to: cpu, disk, diskio, kernel, mem, processes, swap and system.

`sox-n.service` provides the statistical information for each recorded audio file that was determined with `sox `*filename*` -n stat`.
### base data
Here it is planned that the hardware and software configuration will be transferred.
### birds data
The apprise notification option of BirdNET-Pi is currently used to transmit the detection data.
## server
There is currently no complete installation description for the BirdNET-Pi-Cluster server.
an example installation is currently under construction at **[www.BirdNET-Pi-Cluster.net](https://BirdNET-Pi-Cluster.net)**.

It consists of:

[Mosquitto](https://mosquitto.org) is the MQTT Brocker, which receives the data of the clients and forwards them to Telegraf.

[Telegraf](https://www.influxdata.com/time-series-platform/telegraf/) is the agent that receives the data from Mosquitto and passes on to the database. In this case, the plugin [[outputs.postgresql]] is used. This plugin is only available from the Telegraf version 1.24 or higher.

[InfluxDB](https://https://www.influxdata.com/) is an Time Series Data Platform where developers build IoT, analytics, and cloud applications.

[Grafana](https://grafana.com/) is a observation tool, with which the data obtained is graphically prepared.
