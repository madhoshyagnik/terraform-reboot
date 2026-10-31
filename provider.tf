provider "aws" {
  region = "ap-south-1"
}

terraform {
  backend "s3" {
    bucket = "amazn-s3-terraform-state-450730497145-ap-south-1-an"
    # use_lockfile (experimental as of Oct 2026, as opposed to using dynamoDB table)
    use_lockfile = true
    region       = "ap-south-1"
    key          = "envs/pre-prod/terraform.tfstate"
    # dynamodb_table has been deprecated as of Oct 2026
    # dynamodb_table = "state_locking_dynamodb_table"
    encrypt = true
  }
}