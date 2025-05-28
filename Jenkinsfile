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
    }
}
