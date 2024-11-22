pipeline {
    agent any

    environment {
        // Define environment variables for GitHub and Docker
        DOCKER_IMAGE_NAME = "myapp"
        GIT_REPO_URL = "https://github.com/hammadsid1212365/armorcode.git"  // GitHub repository URL
    }

    stages {
        stage('Checkout Code') {
            steps {
                script {
                    // Checkout the code from GitHub repository using credentials
                    git credentialsId: 'github-credentials', url: "${GIT_REPO_URL}"
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh '''
                    docker build -t ${DOCKER_IMAGE_NAME}:latest .
                    '''
                }
            }
        }

        stage('Push Docker Image to Registry') {
            steps {
                script {
                    // If pushing to Docker registry (optional)
                    withDockerRegistry([credentialsId: 'dockerhub-credentials', url: 'https://index.docker.io/v1/']) {
                        sh '''
                        docker tag ${DOCKER_IMAGE_NAME}:latest ${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME}:latest
                        docker push ${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME}:latest
                        '''
                    }
                }
            }
        }
    }

    post {
        always {
            cleanWs()  // Clean workspace after the build
        }
        success {
            echo 'Docker image built and pushed successfully!'
        }
        failure {
            echo 'Build failed.'
        }
    }
}
