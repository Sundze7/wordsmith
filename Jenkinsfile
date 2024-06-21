pipeline {
    agent {label 'docker'}

    environment{
//         SNAPSHOT_REPO = "webapp-snapshot"
//         RELEASE_REPO = "webapp-release"
//         NEXUS_PORT = "8081"
//         NEXUS_CRED = "nexus-login"
        DOCKER_IMG_REGISTRY = "828804287617.dkr.ecr.ca-central-1.amazonaws.com/ws-api"
    }

    stages {
        stage("init") {
            steps {
                script {
                    //def branchName = 'ws-api'
                    git branch: "${env.BRANCH_NAME}", credentialsId: 'github-token', url: 'https://github.com/Sundze7/wordsmith.git'
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
            tools {
                jdk "jdk17"
                maven "maven-3.9.6"
            }
            steps {
                sh 'mvn test'
            }
        }

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
                    def tag = getDockerTag()
                    sh "docker build . -t ${env.DOCKER_IMG_REGISTRY}:${tag}"
                }
            }
        }

        stage("push to ECR") {
            steps {
                script {
                    withAWS(region: 'ca-central-1', credentials: 'aws_creds') {
                        def registry = "828804287617.dkr.ecr.ca-central-1.amazonaws.com/ws-api"
                        def tag = getDockerTag()
                        sh "aws ecr get-login-password | docker login -u AWS --password-stdin ${env.DOCKER_IMG_REGISTRY}"
                        sh "docker push ${env.DOCKER_IMG_REGISTRY}:${tag}" 
                    }
                }
            }
        }
    }

    post {

        always{
            withAWS(region: 'ca-central-1', credentials: "aws_creds") {
                script{
                    //Groovy scripting can be done here
                    def status = currentBuild.result ?: 'SUCCESS'
                    def subject = "${env.JOB_NAME} - Build ${status}: #${env.BUILD_NUMBER}"
                    def message = "Build ${status}: #${env.BUILD_NUMBER}\n\nSee details at: ${env.BUILD_URL}"

                    //Sending the notification to the SNS topic
                    snsPublish topicArn:"arn:aws:sns:ca-central-1:828804287617:ws-api",
                    subject: subject,
                    message: message
                }
            }
            // clean workspace
            // deleteDir()
            // sh "docker rmi ${env.DOCKER_IMG_REGISTRY}:${getDockerTag()} -f"
        }

        success{
            //Deploy the new image
            script{
                def branch = "${env.BRANCH_NAME}"

                if (branch == 'main' || branch == 'master') {
                        // build job: 'cd-webapp',
                        //     wait: false,
                        //     parameters: [
                        //         string(name: 'DOCKER_IMG_REGISTRY', value: '${env.DOCKER_IMG_REGISTRY}'),
                        //         string(name: "IMAGE_TAG", value: getDockerTag())
                        //     ]
                }
            }
            
        }

        // failure{}
    }
}


def getDockerTag() {
     // develop=> 1.1.0.230-rc    | main => 1.1.0.200 | feature => 1.1.0.240-feature-something
    def pom = readMavenPom(file: 'pom.xml')
    // return functions.getDockerImageTag(pom.version)
    def version = pom.version
    def branch = "${env.BRANCH_NAME}"
    def build_number = "${env.BUILD_NUMBER}"

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