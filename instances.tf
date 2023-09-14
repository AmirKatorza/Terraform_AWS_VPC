resource "aws_instance" "amirk-tf-node-1a" {
  instance_type          = "t3.micro"
  ami                    = data.aws_ami.server_ami_debian.id
  key_name               = aws_key_pair.amirk-auth.id
  vpc_security_group_ids = [aws_security_group.amirk-tf-sg.id]
  subnet_id              = aws_subnet.amirk-tf-public-subnet-1a.id
  user_data              = file("userdata.sh")

  root_block_device {
    volume_size = 10
  }

  tags = {
    Name = "amirk-tf-node-1a"
  }

  provisioner "local-exec" {
    command = templatefile("${var.host_os}-ssh-config.tpl", {
      hostname     = self.public_ip,
      user         = "admin",
      identityfile = "~/.ssh/aws-ssh"
    })
    interpreter = ["bash", "-c"]
  }
}

resource "aws_instance" "amirk-tf-node-1b" {
  instance_type          = "t3.micro"
  ami                    = data.aws_ami.server_ami_debian.id
  key_name               = aws_key_pair.amirk-auth.id
  vpc_security_group_ids = [aws_security_group.amirk-tf-sg.id]
  subnet_id              = aws_subnet.amirk-tf-public-subnet-1b.id
  user_data              = file("userdata.sh")

  root_block_device {
    volume_size = 10
  }

  tags = {
    Name = "amirk-tf-node-1b"
  }

  provisioner "local-exec" {
    command = templatefile("${var.host_os}-ssh-config.tpl", {
      hostname     = self.public_ip,
      user         = "admin",
      identityfile = "~/.ssh/aws-ssh"
    })
    interpreter = ["bash", "-c"]
  }
}