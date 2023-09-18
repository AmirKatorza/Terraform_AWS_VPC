data "aws_ami" "server_ami_debian" {
  most_recent = true
  owners      = ["136693071363"]

  filter {
    name   = "name"
    values = ["debian-12-amd64-*-1438"]
  }
}