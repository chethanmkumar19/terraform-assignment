# create the subnet group for the rds instance
resource "aws_db_subnet_group" "database_subnet_group" {
  name         = "database-subnet"
  subnet_ids   = ["subnet-071c8d8b3792e7531", "subnet-0de516c6219a0fb4d"]
  description  = "subnet for database instance"

  tags   = {
    Name = "database-subnet"
  }
}

# create the rds instance
resource "aws_db_instance" "db_instance" {
  engine                  = "mysql"
  engine_version          = "5.7"
  identifier              = var.AWS_IDENTIFIER
  username                = var.AWS_USERNAME
  password                = var.AWS_PASSWORD
  instance_class          = "db.t2.micro"
  allocated_storage       = 200
  db_subnet_group_name    = aws_db_subnet_group.database_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.sg.id]
  availability_zone       = var.AWS_AVAILABILITY_ZONE
  db_name                 = var.AWS_DB_NAME
  publicly_accessible     = false
  
}