########################
#  RDS MySQL (private) #
########################

resource "aws_db_subnet_group" "default" {
  name = "rds-subnet-group"
  subnet_ids = [
    aws_subnet.private.id,
    aws_subnet.private_b.id
  ]
  tags = { Name = "rds-subnet-group" }
}

resource "aws_db_instance" "mysql" {
  identifier        = "store-db"
  allocated_storage = 20
  storage_type      = "gp3"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"

  db_subnet_group_name   = aws_db_subnet_group.default.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  username = var.db_username
  password = var.db_password
  db_name  = "store"

  publicly_accessible     = false
  skip_final_snapshot     = true
  backup_retention_period = 7

  tags = { Name = "store-mysql" }
}
