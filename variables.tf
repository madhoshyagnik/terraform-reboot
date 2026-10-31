variable "instance_type" {
  description = "EC2 instance size"
  type        = string
  default     = "t3.micro"
}

variable "instance_env" {
  description = "EC2 environment this instance belongs to"
  type        = string
  default     = "pre_prod"
}

variable "config_s3_bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "backend_config"
}

variable "subnets" {
  description = "list of subnets"
  type        = list(string)
}