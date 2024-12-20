pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'nextcloud'
        DOCKER_TAG = 'latest'
        DOCKER_REGISTRY = 'docker.io'
        DOCKER_USER = 'sibisam2301'  // Your Docker Hub username
        DOCKER_CREDENTIALS_ID = 'docker-credentials-id'
    }

    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo 'Building Nextcloud Docker Image...'
                    sh """
                        docker build -t ${DOCKER_REGISTRY}/${DOCKER_USER}/${DOCKER_IMAGE}:${DOCKER_TAG} .
                    """
                }
            }
        }

        stage('Deploy Docker Container') {
            steps {
                script {
                    echo 'Deploying Nextcloud Docker container...'
                    
                    // Stop and remove any existing container with the same name
                    sh """
                        docker rm -f nextcloud-container || true
                    """

                    // Run the new Docker container
                    sh """
                        docker run -d --name nextcloud-container -p 9091:80 ${DOCKER_REGISTRY}/${DOCKER_USER}/${DOCKER_IMAGE}:${DOCKER_TAG}
                    """
                }
            }
        }

        stage('Push Docker Image to Registry') {
            steps {
                withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    script {
                        echo 'Pushing Nextcloud Docker image to Docker registry...'
                        sh """
                            echo \$DOCKER_PASSWORD | docker login -u \$DOCKER_USERNAME --password-stdin
                            docker push ${DOCKER_REGISTRY}/${DOCKER_USER}/${DOCKER_IMAGE}:${DOCKER_TAG}
                        """
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline executed successfully!'
        }

        failure {
            echo 'Pipeline failed. Please check the logs for errors.'
        }

        always {
            echo 'Cleaning up Docker container...'
            sh 'docker rm -f nextcloud-container || true'
        }
    }
}



