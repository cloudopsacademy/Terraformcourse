#!/bin/bash

sudo apt update
sudo apt install openjdk-8-jdk -y

# install elasticsearch
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.2.0.deb
sudo dpkg -i elasticsearch-5.2.0.deb

sudo mv /tmp/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
sudo systemctl daemon-reload
sudo systemctl enable elasticsearch.service
sudo systemctl start elasticsearch.service

# install kibana
wget https://artifacts.elastic.co/downloads/kibana/kibana-5.2.0-amd64.deb
sudo dpkg -i kibana-5.2.0-amd64.deb
sudo sysctl -w vm.max_map_count=262144

sudo mv /tmp/kibana.yml /etc/kibana/kibana.yml
sudo systemctl daemon-reload
sudo systemctl enable kibana.service
sudo systemctl start kibana.service

# install logstash
wget https://artifacts.elastic.co/downloads/logstash/logstash-5.2.0.deb
sudo dpkg -i logstash-5.2.0.deb

sudo mv /tmp/logstash.yml /etc/logstash/logstash.yml
sudo systemctl daemon-reload
sudo systemctl start logstash.service
sudo systemctl enable logstash.service

# install filebeats
sudo /usr/share/logstash/bin/logstash-plugin install logstash-input-beats

curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-5.2.0-amd64.deb
sudo dpkg -i filebeat-5.2.0-amd64.deb
sudo mv /tmp/filebeat.yml /etc/filebeat/filebeat.yml

sudo systemctl enable filebeat.service
sudo systemctl start filebeat.service

sudo mv /tmp/beats.conf /etc/logstash/conf.d/beats.conf
sudo curl -XPUT 'http://127.0.0.1:9200/_template/filebeat' -d@/etc/filebeat/filebeat.template.json
