resource "aws_db_subnet_group" "default" {
  name       = "rds-subnet-group"
  subnet_ids = [aws_subnet.private.id]
}

resource "aws_db_instance" "mysql" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = var.db_username
  password             = var.db_password
  db_subnet_group_name = aws_db_subnet_group.default.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot  = true
  publicly_accessible  = false
  identifier           = "store-db"
  db_name              = "store"
}
