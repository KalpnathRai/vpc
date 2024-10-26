/*
provider "aws" {
  region = "us-east-1" # Update this to your preferred region
}
*/
# EKS Cluster
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "my-fargate-cluster"
  cluster_version = "1.31"
  vpc_id          = "vpc-0ab714fcd1b26d08b" # Replace with your VPC ID

  # Specify subnets for the EKS control plane
  subnet_ids = ["subnet-0825a2bd5c059f818", "subnet-071cb22c8ac624dca"] # Replace with your subnet IDs

  # Enabling Fargate profiles
  fargate_profiles = {
    default = {
      selectors = [
        {
          namespace = "default"
        }
      ]
    }
  }

  tags = {
    "Environment" = "dev"
    "Project"     = "fargate-cluster"
  }
}

# Output EKS cluster details
output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "eks_cluster_security_group_id" {
  value = module.eks.cluster_security_group_id
}
