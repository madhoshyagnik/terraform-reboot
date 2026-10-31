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
