data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  key_name               = var.key_name

  user_data = templatefile("${path.module}/userdata.sh", {
    db_host     = aws_db_instance.mysql.address
    db_user     = var.db_username
    db_password = var.db_password
    repo_url    = var.repo_url
  })

  tags = {
    Name = "web-server"
  }
}
