pipeline {
    agent any

    environment {
        IMAGE_NAME = 'local-python-app'   // Docker image name
        CONTAINER_NAME = 'python-app-container'  // Docker container name
    }

    triggers {
        pollSCM('* * * * *')  // Poll the Git repository every minute for changes (set appropriate frequency based on your needs)
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    echo 'Pulling latest code from the repository...'
                    checkout scm  // Pull code from GitHub
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    echo 'Building new Docker image...'
                    docker stop ${CONTAINER_NAME} || true
                    docker rmi --force ${CONTAINER_NAME} || true
                    
                    sh "docker build -t ${IMAGE_NAME}:latest ."
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    echo 'Deploying new Docker container...'
                    sh """
                        # Stop and remove the old container if it exists
                        
                        
                        # Run the new image in a container
                        docker run -d --name ${CONTAINER_NAME}  ${IMAGE_NAME}:latest
                    """
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully. New image built and deployed!'
        }
        failure {
            echo 'Pipeline failed. Please check the logs.'
        }
        always {
            cleanWs()  // Clean up workspace after pipeline run
        }
    }
}
