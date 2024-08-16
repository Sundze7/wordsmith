pipeline {
    agent any
    environment {
        BRANCH_NAME = "master"
        AWS_ACCESS_KEY_ID = credentials('ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = "ca-central-1"
    }
    stages {
        stage("Checkout") {
            steps {
                script {
                    //def branchName = 'ws-api'
                    git branch: "${env.BRANCH_NAME}", credentialsId: 'github-token', url: 'https://github.com/Sundze7/wordsmith.git'
                }
            }
        }
        stage("Create an EKS Cluster") {
            steps {
                script {
                    dir('terraform') {
                        sh "terraform init"
                        sh "terraform apply -auto-approve"
                    }
                }
            }
        }
        stage("Deploy Helm Chart to EKS") {
            steps {
                script {
                    dir('..') {
                        sh "aws eks update-kubeconfig --name myjenkins-server-eks-cluster --region ca-central-1"
                        sh "kubectl get ns"
                        sh "helm uninstall helm-ws"
                        // sh "helm install helm-ws ${WORKSPACE}/ws-chart"
                    }
                }
            }
        }
        // stage("Destroy Resources") {
        //     steps {
        //         script {
        //             dir('terraform') {
        //                 sh "terraform destroy --auto-approve"
        //             }
        //         }
        //     }
        // }
    }
}
