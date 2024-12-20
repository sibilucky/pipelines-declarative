pipeline {
    agent any  // This pipeline will run on any available Jenkins agent

    environment {
        DOCKER_IMAGE = 'nextcloud'  // The name of the Docker image for Nextcloud
        DOCKER_TAG = 'latest'       // Docker tag (you can change this based on your needs)
        DOCKER_REGISTRY = 'docker.io'  // Docker registry (change if you use a private registry)
        DOCKER_USER = 'sibisam2301'  // Your DockerHub username
        DOCKER_CREDENTIALS_ID = 'docker-credentials-id'  // Jenkins credentials ID for Docker login
    }

    stages {
        stage('Checkout SCM') {
            steps {
                // Checkout code from the Git repository where the Dockerfile and any configuration files are stored
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'docker-credentials-id', url: 'https://github.com/sibilucky/pipelines-declarative.git']])
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image for Nextcloud
                    echo 'Building Nextcloud Docker Image...'
                    sh """
                        docker build -t docker.io'/sibisam2301/nextcloud:latest .
                    """
                }
            }
        }

        stage('Deploy Docker Container') {
            steps {
                script {
                    // Ensure there is no existing container running with the same name
                    echo 'Checking if the container exists...'
                    sh """
                        if [ \$(docker ps -aq -f name=nextcloud-container) ]; then
                            echo 'Stopping and removing the existing container...'
                            docker rm -f nextcloud-container
                        fi
                    """
                    
                    // Run the Nextcloud container
                    echo 'Deploying Nextcloud Docker container...'
                    sh """
                        docker run -d --name nextcloud-container -p 9091:80 -v /var/www/html nextcloud:latest
                    """
                }
            }
        }

        stage('Push Docker Image to Registry') {
            steps {
                // Login to Docker registry and push the image to Docker Hub
                withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'sibisam2301@gmail.com', passwordVariable: 'devika@123')]) {
                    script {
                        echo 'Pushing Nextcloud Docker image to registry...'
                        sh """
                            echo devika@123 | docker login -u sibisam2301@gmail.com --password-stdin
                            docker push docker.io/sibisam2301/nextcloud:latest
                        """
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline executed successfully! Nextcloud server is up and running.'
        }

        failure {
            echo 'Pipeline failed. Please check the logs for errors.'
        }

        always {
            // Cleanup - remove the Nextcloud container after execution
            echo 'Cleaning up Docker container...'
            sh 'docker rm -f nextcloud-container || true'
        }
    }
}

