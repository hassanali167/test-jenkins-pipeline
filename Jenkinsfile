pipeline {
    agent any

    environment {
        IMAGE_NAME = 'local-python-app'  // Docker image name
        CONTAINER_NAME = 'python-app-container'  // Docker container name
    }

    triggers {
        githubPush()  // Trigger pipeline on GitHub push events
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm  // Pull code from GitHub
            }
        }
        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:latest ."
            }
        }
        stage('Deploy') {
            steps {
                sh """
                    docker stop ${CONTAINER_NAME} || true
                    docker rm ${CONTAINER_NAME} || true
                    docker run -d --name ${CONTAINER_NAME} ${IMAGE_NAME}:latest
                """
            }
        }
    }

    post {
        always {
            echo 'Pipeline completed successfully.'
        }
    }
}

