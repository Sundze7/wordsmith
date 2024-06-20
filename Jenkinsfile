pipeline {
    agent any

//     environment{
// //         SNAPSHOT_REPO = "webapp-snapshot"
// //         RELEASE_REPO = "webapp-release"
// //         NEXUS_PORT = "8081"
// //         NEXUS_CRED = "nexus-login"
// //         DOCKER_IMG_REGISTRY = "828804287617.dkr.ecr.ca-central-1.amazonaws.com/webapp"
//     }

    stages {
        stage("init") {
            steps {
                script {
                    //def branchName = 'ws-api'
                    git branch: "${env.BRANCH_NAME}", credentialsId: 'github-token', url: 'https://github.com/Sundze7/wordsmith.git'
                }
            }
        }

        // stage("Build") {
        //     tools {
        //         jdk "jdk17"
        //         maven "maven-3.9.6"
        //     }
        //     steps {
        //         sh 'mvn clean package'
        //     }
        // }

        // stage("Test") {
        //     tools {
        //         jdk "jdk17"
        //         maven "maven-3.9.6"
        //     }
        //     steps {
        //         sh 'mvn test'
        //     }
        // }

        // stage ("Sonar Scan") {
        //     tools {
        //         jdk "jdk11"
        //         maven "maven-3.9.6"
        //     }
        //     steps {
        //         withSonarQubeEnv('sonar') {
        //             sh 'mvn org.sonarsource.scanner.maven:sonar-maven-plugin:3.7.0.1746:sonar'
        //         }
        //     }
        // }

        // stage("Quality gates") {
        //     steps {
        //         timeout(time: 4, unit: "MINUTES") {
        //             waitForQualityGate abortPipeline: true
        //         }
        //     }
        // }

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