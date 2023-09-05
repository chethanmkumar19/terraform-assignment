resource "aws_security_group" "sg" {
  name        = "chethan-rds-sg"
  description = "Allow access on port 22"
  vpc_id      = "vpc-033337d9f960a246b"

  ingress {
    description = "mysql access"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "database-security-group"
  }
}