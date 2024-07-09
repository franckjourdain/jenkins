pipeline {
    agent any

    environment {
        // Define environment variables if needed
        DOCKER_IMAGE = "c73f7d8602800cf6fb88289039f86de31e6ab85d9bf5b358e032e889f2853a2e"
        DOCKER_TAG = "latest"
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the source code from your repository
                git 'https://github.com/francjourdain/jenkins.git'
            }
        }

        stage('Build') {
            steps {
                script {
                    // Build the Docker image
                    sh './mvnw clean package'
                    sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    // Run your tests here
                    // For example, you could run a container from the built image and execute tests inside it
                    sh "docker run --rm ${DOCKER_IMAGE}:${DOCKER_TAG} "
                }
            }
        }

        stage('Push') {
            steps {
                script {
                    // Use Docker credentials to log in and push the image
                    withCredentials([usernamePassword(credentialsId: 'credentialsid', usernameVariable: 'DOCKER_HUB_USERNAME', passwordVariable: 'DOCKER_HUB_PASSWORD')]) {
                        sh "echo $DOCKER_HUB_PASSWORD | docker login -u $DOCKER_HUB_USERNAME --password-stdin"
                        sh "docker push ${DOCKER_IMAGE}:${DOCKER_TAG}"
                    }
                }
            }
        }
    }

    post {
        always {
            // Cleanup
            script {
                sh "docker rmi ${DOCKER_IMAGE}:${DOCKER_TAG}"
            }
        }
    }
}