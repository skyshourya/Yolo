pipeline {
    agent any

    environment {
        IMAGE_NAME = 'jazzyolo'
        IMAGE_TAG = 'latest'
    }

    stages {
        stage('Clone Code from GitHub') {
            steps {
                echo 'Cloning the code from GitHub...'
                git url: "https://github.com/skyshourya/Yolo.git", branch: "master"
                echo 'Code cloning successful.'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building the Docker image...'
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
            }
        }

        stage('Run Application (Deployment)') {
            steps {
                echo 'Running the application using Docker Compose...'
                sh 'docker compose up -d'
            }
        }
    }

    post {
        success {
            echo 'Deployment completed successfully!'
        }
        failure {
            echo 'Deployment failed!'
        }
    }
}
