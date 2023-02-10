#under construction
#sudo apt install mosquitto-clients
MAC_ADRESS=`./getMacAdress.sh`
mosquitto_pub -h 49.12.4.122  -t "birdnet-pi_cl/$MAC_ADRESS/birds" -m "{\"host\".\"$MAC_ADRESS\",\"sciname\":\"Turdus merula\",\"comname\":\"Eurasian Blackbird\",\"confidence\":\"0.9724654\",\"lat\":\"48.15\",\"lng\":\"11.5833\",\"dt\":\"2022-08-12 19:42:40\",\"week\":\"30\",\"sens\":\"1.25\",\"cutoff\":\"0.7\",\"overlap\":\"0.0\"}"
