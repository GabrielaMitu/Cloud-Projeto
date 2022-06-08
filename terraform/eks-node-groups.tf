# Resorce aws_iam_role
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs

resource "aws_iam_role" "nodes_general" {
  name = "eks-node-group-general-Mitu"

  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
            "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
POLICY
}

# Attach 3 different policies 

resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy_general" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"

  role = aws_iam_role.nodes_general.name
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy_general" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"

  role = aws_iam_role.nodes_general.name
}

resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_read_only" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"

  role = aws_iam_role.nodes_general.name
}


### Instancias ###

resource "aws_eks_node_group" "nodes_general" {
  cluster_name = aws_eks_cluster.eks.name # qual cluster eu quero usar

  node_group_name = "nodes-general-Mitu" # attach the 3 policies

  node_role_arn = aws_iam_role.nodes_general.arn

  subnet_ids = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ]

  scaling_config {
    desired_size = 3 # número desejado de worker nodes
    max_size     = 3 # número maximo de worker nodes
    min_size     = 3 # número minimo de worker nodes
  }

  ami_type             = "AL2_x86_64"
  capacity_type        = "ON_DEMAND"
  disk_size            = 20 # Disk size in GiB para os worker nodes
  force_update_version = false
  instance_types       = ["t2.small"]

  labels = {
    "role" = "nodes-general"
  }
  
  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_worker_node_policy_general,
    aws_iam_role_policy_attachment.amazon_eks_cni_policy_general,
    aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only,
  ]
}
