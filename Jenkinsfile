pipeline {
    agent any
    stages {
        stage("init") {
            steps {
                sh 'echo "init stage"'
            }
        }

        stage("Build") {
            steps {
                sh 'echo "Build stage"'
            }
        }

        stage("Test") {
            steps {
                sh 'echo "Test stage"'
            }
        }

        stage("Quality gates") {
            steps {
                sh 'echo "Quality gates stage"'
            }
        }

        stage("Store Java artifact") {
            steps {
                sh 'echo "Store Java artifact stage"'
            }
        }

        stage("create docker image") {
            steps {
                sh 'echo "create docker image stage"'
            }
        }

        stage("push to ECR") {
            steps {
                sh 'echo "push to ECR stage"'
            }
        }

        stage("image scan") {
            steps {
                sh 'echo "image scan stage"'
            }
        }
    }
}