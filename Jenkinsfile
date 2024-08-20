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

        // stage("Create an EKS Cluster") {
        //     steps {
        //         script {
        //             dir('terraform') {
        //                 sh "terraform init"
        //                 sh "terraform apply -auto-approve"
        //             }
        //         }
        //     }
        // }

        // stage("Setup ArgoCD") {
        //     steps {
        //         script {
        //             sh "aws eks update-kubeconfig --name myjenkins-server-eks-cluster --region ca-central-1"

        //             // Create ArgoCD namespace
        //             sh "kubectl create namespace argocd || true"

        //             // Install ArgoCD using manifests
        //             sh "kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml"

        //             // Expose ArgoCD server as LoadBalancer for browser access
        //             sh '''
        //             kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
        //             '''

        //             // Wait for ArgoCD components to be ready
        //             sh "kubectl rollout status deploy/argocd-server -n argocd"
        //         }
        //     }
        // }

        // stage("Configure ArgoCD") {
        //     steps {
        //         script {
        //             // Get ArgoCD initial admin password from the server pod's name
        //             sh "aws eks update-kubeconfig --name myjenkins-server-eks-cluster --region ca-central-1"
        //             sh '''
        //             ARGOCD_PASSWORD=$(kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o jsonpath='{.items[0].metadata.name}')
        //             argocd login --insecure --username admin --password $ARGOCD_PASSWORD --grpc-web argocd-server.argocd.svc.cluster.local:443
        //             '''

        //             // Register EKS cluster with ArgoCD
        //             sh "argocd cluster add \$(kubectl config current-context)"

        //             // Create an ArgoCD application to sync the Git repository with the cluster
        //             sh '''
        //             argocd app create wordsmith-app \
        //                 --repo https://github.com/Sundze7/wordsmith.git \
        //                 --path ws-chart \
        //                 --dest-server https://kubernetes.default.svc \
        //                 --dest-namespace default
        //             '''

        //             // Sync the application
        //             sh "argocd app sync wordsmith-app"
        //         }
        //     }
        // }
        
        // stage("Display ArgoCD Access URL") {
        //     steps {
        //         script {
        //             // Get the External IP of the ArgoCD server and display it
        //             sh '''
        //             EXTERNAL_IP=$(kubectl get svc argocd-server -n argocd -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
        //             echo "Access ArgoCD at: https://$EXTERNAL_IP"
        //             '''
        //         }
        //     }
        // }

        // stage("Deploy Helm Chart to EKS") {
        //     steps {
        //         script {
        //             dir('..') {
        //                 sh "aws eks update-kubeconfig --name myjenkins-server-eks-cluster --region ca-central-1"
        //                 sh "kubectl get ns"
        //                 // sh "helm uninstall helm-ws"
        //                 sh "helm install helm-ws ${WORKSPACE}/ws-chart"
        //             }
        //         }
        //     }
        // }

        stage("Destroy Resources") {
            steps {
                script {
                    dir('terraform') {
                        sh "terraform destroy --auto-approve"
                    }
                }
            }
        }
    }
}
