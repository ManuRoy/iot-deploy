#!/bin/bash

# Deploy Node-RED flow (replace URL if different)
curl -X POST http://localhost:1880/flows -H "Content-Type: application/json" -d @node-red/flow.json

# Copy Logstash config
cp logstash/rabbitmq-to-es.conf /etc/logstash/conf.d/rabbitmq-to-es.conf

# Restart Logstash to apply config
systemctl restart logstash

# Register index template
curl -k -u elastic:PlnLz35OqHQ1UAOLqo8b -X PUT "https://localhost:9200/_index_template/sensor_template" \
-H 'Content-Type: application/json' \
-d @elasticsearch/index-template.json
