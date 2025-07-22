variable "vpc_cidr" { default = "10.0.0.0/16" }
variable "public_subnet_cidr" { default = "10.0.1.0/24" }
variable "private_subnet_cidr" { default = "10.0.2.0/24" }
variable "db_username" { default = "admin" }
variable "db_password" { default = "ChangeMe123!" }
variable "key_name" { description = "EC2 key pair" }
variable "repo_url" { default = "https://github.com/YOUR_USER/aws-terraform-proyecto.git" }
