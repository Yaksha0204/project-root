pipeline {
    agent any

    environment {
        DOCKERHUB_USER = 'Yaksha0204'
        DOCKERHUB_PASS = credentials('Gitfor@20')
        WORKER_IP = '43.204.150.125'
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/Yaksha0204/project-root'
            }
        }

        stage('Build & Push Docker Images') {
            steps {
                script {
                    docker.withRegistry('', 'dockerhub-password-id') {
                        sh 'docker build -t $DOCKERHUB_USER/service1 ./services/service1'
                        sh 'docker push $DOCKERHUB_USER/service1'
                        sh 'docker build -t $DOCKERHUB_USER/service2 ./services/service2'
                        sh 'docker push $DOCKERHUB_USER/service2'
                    }
                }
            }
        }

        stage('Deploy to Worker') {
            steps {
                script {
                    sh """
                    ssh -o StrictHostKeyChecking=no ubuntu@$WORKER_IP \\
                    'docker pull $DOCKERHUB_USER/service1 && docker run -d -p 5000:5000 $DOCKERHUB_USER/service1'
                    ssh -o StrictHostKeyChecking=no ubuntu@$WORKER_IP \\
                    'docker pull $DOCKERHUB_USER/service2 && docker run -d -p 5001:5001 $DOCKERHUB_USER/service2'
                    """
                }
            }
        }
    }
}
