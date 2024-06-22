#eks-cluster.tf
module "eks" {
    source  = "terraform-aws-modules/eks/aws"
    version = "~> 19.0"
    cluster_name = "myjenkins-server-eks-cluster"
    cluster_version = "1.24"

    cluster_endpoint_public_access  = true

    vpc_id = "vpc-02fa0c5292a4b44bf"
    subnet_ids = module.myjenkins-server-vpc.public_subnets
    # subnet_ids = "subnet-04158b6f5c1547e2a"

    tags = {
        environment = "development"
        application = "eks-server"
    }

    eks_managed_node_groups = {
        dev = {
            min_size = 1
            max_size = 3
            desired_size = 2

            instance_types = ["t2.small"]
        }
    }
}