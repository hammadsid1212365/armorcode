pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'your-docker-image-name'
        DOCKER_REGISTRY = 'your-docker-registry-url'
        DEPLOY_SERVER = 'remote-server-ip'
        DEPLOY_USER = 'your-deploy-user'
    }
    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out code...'
                checkout scm
            }
        }
        stage('Build') {
            steps {
                echo 'Building the application...'
                sh 'docker build -t ${DOCKER_IMAGE}:${BUILD_NUMBER} .'
            }
        }
        stage('Test') {
            steps {
                echo 'Running tests...'
                sh 'docker run --rm ${DOCKER_IMAGE}:${BUILD_NUMBER} ./run-tests.sh'
            }
        }
        stage('Push to Registry') {
            steps {
                echo 'Pushing the Docker image to the registry...'
                sh '''
                    docker tag ${DOCKER_IMAGE}:${BUILD_NUMBER} ${DOCKER_REGISTRY}/${DOCKER_IMAGE}:${BUILD_NUMBER}
                    docker push ${DOCKER_REGISTRY}/${DOCKER_IMAGE}:${BUILD_NUMBER}
                '''
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying the application...'
                sshagent(['your-ssh-credentials-id']) {
                    sh '''
                        ssh ${DEPLOY_USER}@${DEPLOY_SERVER} "
                        docker pull ${DOCKER_REGISTRY}/${DOCKER_IMAGE}:${BUILD_NUMBER} &&
                        docker stop app-container || true &&
                        docker rm app-container || true &&
                        docker run -d --name app-container -p 80:80 ${DOCKER_REGISTRY}/${DOCKER_IMAGE}:${BUILD_NUMBER}
                        "
                    '''
                }
            }
        }
    }
    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
