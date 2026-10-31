data "aws_ami" "amzn2023-ami" {
  most_recent = true
  owners      = ["amazon"]

  # Explicitly target the standard Amazon Linux 2023 base image names
  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}


resource "aws_instance" "ec2_instance" {
  ami           = data.aws_ami.amzn2023-ami
  instance_type = var.instance_type
}