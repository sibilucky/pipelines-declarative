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
                        docker build -t docker.io/sibisam2301/nextcloud:latest .
                    """
                }
            }
        }

        stage('Deploy Docker Container') {
            steps {
                script {
                    echo 'Deploying Nextcloud Docker container...'

                    // Run the new Docker container
                    sh """
                        docker run -d --name nextcloud-container -p 9091:80 docker.io/sibisam2301/nextcloud:latest
                    """
                }
            }
        }

        stage('Push Docker Image to Registry') {
            steps {
                withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'sibisam2301@gmail.com', passwordVariable: 'devika@123')]) {
                    script {
                        echo 'Pushing Nextcloud Docker image to Docker registry...'
                        sh """
                            echo  devika@123 | docker login -u sibisam2301@gmail.com --password-stdin
                            docker push docker.io/sibisam2301/nextcloud:latest
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
           
        }
    }
}



