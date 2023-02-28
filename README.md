# BirdNET-Pi_cluster

**BirdNET-Pi_cluster** is an expansion to the great [**BirdNet-Pi**](https://github.com/mcguirepr89/BirdNET-Pi) project, which birds recognize on their voice and processes at the local level.

**BirdNET-Pi_cluster** collects the data from several BirdNET-Pi stations for statistical processing.
This makes it possible to make observations about the vitality and diversity of the bird population. Different locations can be compared with one another or with a group of locations and/or viewed over time.

All relevant data is transferred to the **BirdNET-Pi_cluster** server by the client  via [MQTT](https://mqtt.org/). It is therefore not necessary to open your home network to access from the internet.

## client
The client (your [**BirdNet-Pi**](https://github.com/mcguirepr89/BirdNET-Pi) station) provides the server data on its technical health, base data and the recognitions of birds.
## install:
`git clone git@github.com:PeterEwertz/birdnet_pi_cluster.git
`### health
`telegraf.service` offers the transmission of data to: cpu, disk, diskio, kernel, mem, processes, swap and system.

`sox-n.service` provides the statistical information for each recorded audio file that was determined with `sox `*filename*` -n stat`.
### base
Here it is planned that the hardware and software configuration will be transferred.
### birds 
The apprise notification option of BirdNET-Pi is currently used to transmit the detection data.
## server
[Mosquitto](https://mosquitto.org) is the MQTT Brocker, which receives the data of the clients and forwards them to Telegraf.

[Telegraf](https://www.influxdata.com/time-series-platform/telegraf/) is the agent that receives the data from Mosquitto and passes on to the database. In this case, the plugin [[outputs.postgresql]] is used. This plugin is only available from the Telegraf version 1.24 or higher.

[Postgresql](https://www.postgresql.org/) is an object -oriented SQL database. With the expansion of Timescale, it is particularly suitable for the time series evaluation.

[Grafana](https://grafana.com/) is a observation tool, with which the data obtained is graphically prepared.
