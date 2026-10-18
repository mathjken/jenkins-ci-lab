pipeline {
    agent any

    triggers {
        pollSCM('H/5 * * * *')
    }

    options {
        buildDiscarder(logRotator(
            numToKeepStr: '10',
            artifactNumToKeepStr: '5'
        ))
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
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

        stage('Package') {
            steps {
                sh '''
                    mkdir -p dist
                    zip -j dist/jenkins-ci-lab.zip \
                        app.py test_app.py requirements.txt
                '''
            }
        }

        stage('Docker Build and Push') {
            steps {
                sh '''
                    docker build \
                        -t mathjken/jenkins-ci-lab:${BUILD_NUMBER} .
                    docker tag \
                        mathjken/jenkins-ci-lab:${BUILD_NUMBER} \
                        mathjken/jenkins-ci-lab:latest
                '''

                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-credentials',
                        usernameVariable: 'DOCKERHUB_USER',
                        passwordVariable: 'DOCKERHUB_TOKEN'
                    )
                ]) {
                    sh '''
                        set +x
                        echo "$DOCKERHUB_TOKEN" | docker login \
                            -u "$DOCKERHUB_USER" --password-stdin
                        trap 'docker logout >/dev/null 2>&1 || true' EXIT
                        docker push mathjken/jenkins-ci-lab:${BUILD_NUMBER}
                        docker push mathjken/jenkins-ci-lab:latest
                    '''
                }
            }
        }

        stage('Publish Artifact') {
            steps {
                archiveArtifacts(
                    artifacts: 'dist/jenkins-ci-lab.zip',
                    fingerprint: true
                )
            }
        }
    }
}
