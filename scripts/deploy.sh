pipeline {
    agent any

    stages {
        stage('Deploy Node-RED Flow') {
            steps {
                sh 'curl -X POST http://localhost:1880/flows -H "Content-Type: application/json" -d @node-red/flow.json'
            }
        }

        stage('Configure Logstash') {
            steps {
                sh '''
                cp logstash/rabbitmq-to-es.conf /etc/logstash/conf.d/rabbitmq-to-es.conf
                systemctl restart logstash
                '''
            }
        }

        stage('Register Elasticsearch Index Template') {
            steps {
                sh '''
                curl -k -u elastic:PlnLz35OqHQ1UAOLqo8b -X PUT "https://localhost:9200/_index_template/sensor_template" \
                -H "Content-Type: application/json" \
                -d @elasticsearch/index-template.json
                '''
            }
        }

        stage('Inject Sample Data via Node-RED') {
            steps {
                // Trigger the inject node programmatically
                sh 'curl -X POST http://localhost:1880/inject/bdf4c11c1aaee942'
            }
        }

        stage('Verify Index Created') {
            steps {
                sh 'curl -k -u elastic:PlnLz35OqHQ1UAOLqo8b https://localhost:9200/_cat/indices?v'
            }
        }
    }
}
