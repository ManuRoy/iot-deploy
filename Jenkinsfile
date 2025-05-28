pipeline {
    agent any

    stages {
        stage('Clean Up') {
            steps {
                sh 'bash scripts/clear-data.sh'
            }
        }

        stage('Deploy') {
            steps {
                sh 'bash scripts/deploy.sh'
            }
        }

        stage('Verify Index') {
            steps {
                sh '''
                    curl -k -u elastic:PlnLz35OqHQ1UAOLqo8b https://localhost:9200/_cat/indices?v
                '''
            }
        }
    }
}
