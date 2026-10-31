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

data "aws_s3_objects" "state_bucket" {
  bucket = "amazn-s3-terraform-state-450730497145-ap-south-1-an"
}

data "aws_vpc" "get_default_vpc" {
  default = true
}

data "aws_instances" "find_existing_instances" {
  filter {
    name   = "tag:name"
    values = [upper("environment_pre_prod")]
  }
}

# Note: doesn't work if no subnets actually have that tag attached
data "aws_subnets" "list_public_subnets" {
  filter {
    name   = "tag:Type"
    values = ["public"]
  }
}

resource "aws_instance" "api_instance" {
  count         = var.enable_ec2_creation ? 1 : 0
  ami           = data.aws_ami.amzn2023_ami.id
  instance_type = var.instance_type

  lifecycle {
    # create_before_destroy = true
    # prevent_destroy = true
    ignore_changes = [tags, user_data]
  }

  associate_public_ip_address = var.associate_public_ip
  tags = {
    name = upper("environment_${var.instance_env}")
  }
}

resource "aws_s3_bucket" "config_s3_bucket" {
  count  = var.enable_s3_bucket_creation ? 1 : 0
  bucket = join("-", ["amazon", var.config_s3_bucket_name])
}


output "check_length" {
  value = length(trimspace(" elephant "))
}

output "instance_id" {
  value = one(aws_instance.api_instance[*].id)
}

output "instance_ip" {
  value = one(aws_instance.api_instance[*].public_ip)
}

output "instance_dns" {
  value = one(aws_instance.api_instance[*].public_dns)
}

output "instance_arn" {
  description = "ARM of the EC2 instance"
  value       = one(aws_instance.api_instance[*].arn)
  sensitive   = true
}

output "state_bucket_contents" {
  value = data.aws_s3_objects.state_bucket.keys
}

output "default_vpc_id" {
  value = data.aws_vpc.get_default_vpc.id
}

output "instance_lookups" {
  value = data.aws_instances.find_existing_instances.ids
}

output "public_subnets_lookup" {
  value = data.aws_subnets.list_public_subnets.ids
}

/*
Use only the outputs needed so you don't pollute the codebase
*/