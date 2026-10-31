variable "instance_type" {
  #   description = "EC2 instance size"
  #   type        = string
  #   default     = "t3.micro"
  validation {
    condition     = contains(["t3.micro"], var.instance_type)
    error_message = "Invalid instance type"
  }
}

variable "enable_ec2_creation" {
  type = bool
  #   default = false
}

variable "enable_s3_bucket_creation" {
  type = bool
  #   default = false
}

variable "associate_public_ip" {
  type = bool
  #   default = true
}

variable "instance_env" {
  description = "EC2 environment this instance belongs to"
  type        = string
  #   default     = "pre_prod"
  validation {
    condition     = contains(["pre_prod"], var.instance_env)
    error_message = "Deployments are allowed only in pre_prod"
  }
}

variable "config_s3_bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  #   default     = "backend_config"
  #   sensitive = true
}

# variable "subnets" {
#   description = "list of subnets"
#   type        = list(string)
# }