/*
terraform {
  required_version = ">=0.12.0"
  backend "s3" {
    key            = "terraformstatefile"
    bucket         = "yanick-bucket-v6"
    region         = "us-east-2"
    dynamodb_table = "terraform-state-locking"
  }
}
*/