resource "aws_instance" "ec2" {
  ami = "ami-0f5ee92e2d63afc18"
  instance_type = "t2.micro"
  tags = {
    Name = "chethan instance"
  }

}