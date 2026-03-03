data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amazon-linux/images/hvm-ssd/amazon-linux-2023-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"] # Canonical
}

resource "aws_instance" "example" {
  ami           = data.aws_ami.amazon_linux.id
  key_name      = "dockerKeyPair"
  instance_type = "t3.micro"
  tags = {
    Name = "EC2_Instance-tf"
  }

  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  subnet_id = aws_subnet.public_subnet.id
  lifecycle { 
    ignore_changes = [ami]
  }
}