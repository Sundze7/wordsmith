pipeline {
    agent {label 'docker'}

    environment{
//         SNAPSHOT_REPO = "webapp-snapshot"
//         RELEASE_REPO = "webapp-release"
//         NEXUS_PORT = "8081"
//         NEXUS_CRED = "nexus-login"
        DOCKER_IMG_REGISTRY = "828804287617.dkr.ecr.ca-central-1.amazonaws.com/ws-db"
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the repository using the 'checkout' step
                checkout([$class: 'GitSCM',
                    branches: [[name: '*/ws-db']], // Specify the branch to checkout
                    userRemoteConfigs: [[url: 'https://github.com/Sundze7/wordsmith.git']]]) // Specify the repository URL
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

        stage("Build docker image") {
            steps {
                script {
                    // def tag = getDockerTag()
                    sh "docker build . -t ${env.DOCKER_IMG_REGISTRY}:${latest}"
                }
            }
        }

        stage("push to ECR") {
            steps {
                script {
                    withAWS(region: 'ca-central-1', credentials: 'aws_creds') {
                        def registry = "828804287617.dkr.ecr.ca-central-1.amazonaws.com/ws-db"
                        // def tag = getDockerTag()
                        sh "aws ecr get-login-password | docker login -u AWS --password-stdin ${env.DOCKER_IMG_REGISTRY}"
                        sh "docker push ${env.DOCKER_IMG_REGISTRY}:${latest}" 
                    }
                }
            }
        }
    }
}



def getDockerTag() {
     // develop=> 1.1.0.230-rc    | main => 1.1.0.200 | feature => 1.1.0.240-feature-something
    // def pom = readMavenPom(file: 'pom.xml')
    // // return functions.getDockerImageTag(pom.version)
    // def version = pom.version
    // def branch = "${env.BRANCH_NAME}"
    // def build_number = "${env.BUILD_NUMBER}"

    def tag = "" 

    if (branch == 'main' || branch == 'master') {
        tag = "${version}.${build_number}"
    } else if(branch == "develop") {
        tag = "${version}.${build_number}-rc"
    } else {
        branch = branch.replace("/", "-").replace("\\", "-")
        tag = "${version}.${build_number}-${branch}"
    }

    return tag 
}

def getRegistry() {
    return true
}