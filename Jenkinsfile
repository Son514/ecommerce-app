pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/your-username/ecommerce-app.git'
            }
        }
        stage('Build Docker Images') {
            steps {
                sh 'docker build -t frontend:latest ./frontend'
                sh 'docker build -t product-service:latest ./backend/product-service'
            }
        }
        stage('Deploy to MicroK8s') {
            steps {
                sh 'kubectl apply -f k8s/frontend-deployment.yaml'
                sh 'kubectl apply -f k8s/product-service-deployment.yaml'
                sh 'kubectl apply -f k8s/db-deployment.yaml'
            }
        }
    }
}