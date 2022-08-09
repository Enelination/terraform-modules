# store the terraform state file in s3
terraform {
  backend "s3" {
    bucket  = "ea-terra-remote-state"
    key     = "xeros-website-ecs.tfstate"
    region  = "us-east-1"
    profile = "aws-profile"
  }
}
