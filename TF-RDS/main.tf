provider "aws" {
  region = "us-east-1"
}

resource "aws_db_subnet_group" "subnet_group" {
  name       = "ecommerce-subnet-group"
  subnet_ids = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
}

resource "aws_db_instance" "rds_instance" {
  identifier             = "ecommerce-rds"
  engine                 = "mysql"
  instance_class         = "db.t2.micro"
  allocated_storage      = 20
  storage_type           = "gp2"
  engine_version         = "5.7"
  multi_az               = true
  publicly_accessible   = false
  username               = var.db_username
  password               = var.db_password
  name                   = "ecommerce_database"
  db_subnet_group_name   = aws_db_subnet_group.subnet_group.name
  iam_database_authentication_enabled = true
  vpc_security_group_ids = [aws_security_group.rds_security_group.id]

  tags = {
    Name = "ecommerce-rds"
  }
}

resource "aws_security_group" "rds_security_group" {
  vpc_id = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-security-group"
  }
}
