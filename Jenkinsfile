pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                sh '''
                    mkdir -p dist
                    zip -j dist/jenkins-ci-lab.zip app.py test_app.py requirements.txt
                '''
            }
        }

        stage('Test') {
            steps {
                sh '''
                    python3 -m venv .venv
                    . .venv/bin/activate
                    pip install -r requirements.txt
                    python -m pytest --junitxml=test-results.xml
                '''
                junit 'test-results.xml'
            }
        }

        stage('Deploy') {
            steps {
                archiveArtifacts artifacts: 'dist/jenkins-ci-lab.zip', fingerprint: true
            }
        }
    }
}
