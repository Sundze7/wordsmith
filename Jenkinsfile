pipeline {
    agent any

    environment{
//         SNAPSHOT_REPO = "webapp-snapshot"
//         RELEASE_REPO = "webapp-release"
//         NEXUS_PORT = "8081"
//         NEXUS_CRED = "nexus-login"
//         DOCKER_IMG_REGISTRY = "828804287617.dkr.ecr.ca-central-1.amazonaws.com/webapp"
    }

    stages {
        stage("init") {
            steps {
                script {
                    def branchName = 'ws-api'
                    git branch: branchName, credentialsId: 'github-token', url: 'https://github.com/Sundze7/wordsmith.git'
                }
            }
        }

        stage("Build") {
            tools {
                jdk "jdk17"
                maven "maven-3.9.6"
            }
            steps {
                sh 'mvn clean package'
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