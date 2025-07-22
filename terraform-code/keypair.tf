#####################
#  EC2 Key Pair     #
#####################

# Crea el Key Pair en AWS usando tu clave pública
resource "aws_key_pair" "user1" {
  key_name   = var.key_name # "user1keypair"
  public_key = file("${path.module}/${var.public_key_path}")
}
