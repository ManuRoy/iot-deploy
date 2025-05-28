#!/bin/bash

# Deploy Node-RED flow
curl -X POST http://localhost:1880/flows \
  -H "Content-Type: application/json" \
  -d @node-red/flow.json

# Configure Logstash
cp logstash/rabbitmq-to-es.conf /etc/logstash/conf.d/
systemctl restart logstash

# Register Elasticsearch index template
curl -k -u elastic:PlnLz35OqHQ1UAOLqo8b -X PUT "https://localhost:9200/_index_template/sensor_template" \
  -H "Content-Type: application/json" \
  -d @elasticsearch/index-template.json

# Inject sample data via Node-RED
curl -X POST http://localhost:1880/inject/bdf4c11c1aaee942
