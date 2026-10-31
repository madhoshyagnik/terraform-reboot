data "aws_ami" "amzn2023_ami" {
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

resource "aws_instance" "api_instance" {
  ami           = data.aws_ami.amzn2023_ami.id
  instance_type = var.instance_type

  associate_public_ip_address = true
  tags = {
    name = upper("environment_${var.instance_env}")
  }
}

resource "aws_s3_bucket" "config_s3_bucket" {
  bucket = join("_", ["amazon", var.config_s3_bucket_name])
}


output "check_length" {
  value = length(trimspace(" elephant "))
}

output "instance_id" {
  value = aws_instance.api_instance.id
}

output "instance_ip" {
  value = aws_instance.api_instance.public_ip
}

output "instance_dns" {
  value = aws_instance.api_instance.public_dns
}

/*
Use only the outputs needed so you don't pollute the codebase
*/