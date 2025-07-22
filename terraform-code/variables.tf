variable "vpc_cidr" { default = "10.0.0.0/16" }
variable "public_subnet_cidr" { default = "10.0.1.0/24" }
variable "private_subnet_cidr" { default = "10.0.2.0/24" }
variable "db_username" { default = "admin" }
variable "db_password" { default = "ChangeMe123!" }
variable "key_name" { description = "EC2 key pair" }
variable "repo_url" { default = "https://github.com/YOUR_USER/aws-terraform-proyecto.git" }
variable "private_subnet_b_cidr" {
  description = "CIDR de la segunda subnet privada (us-east-1b)"
  type        = string
  default     = "10.0.3.0/24" # cámbialo si prefieres otro rango
}
variable "public_key_path" {
  description = "Path al archivo de clave pública RSA que se cargará como Key Pair en AWS"
  type        = string
  default     = "C:/Users/Lenovo/.ssh/user1keypair.pub"
}