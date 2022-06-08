resource "aws_iam_role" "eks_cluster" {
  name = "eks-cluster-Mitu"

  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "eks.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cluster_policy" {
  # ARN of the policy you want ot apply
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"

  #The role the policy should be applied to
  role = aws_iam_role.eks_cluster.name
}

resource "aws_eks_cluster" "eks" {
  name = "eksMitu"

  role_arn = aws_iam_role.eks_cluster.arn


  vpc_config {
    # Indica se o servidor Amazon EKS private/public API endpoint ta ativo ou nao
    endpoint_private_access = false
    endpoint_public_access  = true
    subnet_ids = [
      aws_subnet.public_1.id,
      aws_subnet.public_2.id,
      aws_subnet.private_1.id,
      aws_subnet.private_2.id
    ]
  }
  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_cluster_policy
  ]
}