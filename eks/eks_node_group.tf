resource "aws_instance" "chethan-server" {
  ami                         = "ami-0f5ee92e2d63afc18"
  key_name                    = "kubernetes-assignment"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public-1.id
  vpc_security_group_ids      = [aws_security_group.sg.id]

  tags = {
    Name = "chethan-server-main"
  }

}

resource "aws_eks_node_group" "node-grp" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "chethan-node-group"
  node_role_arn   = aws_iam_role.worker.arn
  subnet_ids      = [aws_subnet.public-1.id, aws_subnet.public-2.id]
  capacity_type   = "ON_DEMAND"
  disk_size       = "20"
  instance_types  = ["t2.small"]

  remote_access {
    ec2_ssh_key               = "kubernetes-assignment"
    source_security_group_ids = [aws_security_group.sg.id]
  }

  labels = tomap({ env = "dev" })

  scaling_config {
    desired_size = 3
    max_size     = 4
    min_size     = 2
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    #aws_subnet.pub_sub1,
    #aws_subnet.pub_sub2,
  ]
}