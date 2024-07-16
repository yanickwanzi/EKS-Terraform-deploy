
################################################################################
# Default Variables
################################################################################

variable "main-region" {
  type    = string
  default = "us-east-2"
}


################################################################################
# EKS Cluster Variables
################################################################################

variable "cluster_name" {
  type    = string
  default = "dominion-cluster"
}

variable "rolearn" {
  description = "Add admin role to the aws-auth configmap"
  default     = "arn:aws:iam::322266404742:role/terraform-create-role"
}

################################################################################
# ALB Controller Variables
################################################################################

variable "env_name" {
  type    = string
  default = "dev"
}

################################################################################
# EKS Cluster Variables for grafana and prometheus deployment
################################################################################

 variable "cluster_endpoint" {
   type        = string
   sensitive   = true
   description = "The cluster endpoint"
 }

 variable "cluster_certificate_authority_data" {
   type        = string
   sensitive   = true
   description = "The Cluster certificate data"
 }

 variable "oidc_provider_arn" {
   description = "OIDC Provider ARN used for IRSA "
   type        = string
   sensitive   = true
 }

################################################################################
# VPC Variables
################################################################################

# variable "vpc_id" {
#   description = "VPC ID which Load balancers will be  deployed in"
#   type        = string
# }

# variable "private_subnets" {
#   description = "A list of private subnets"
#   type        = list(string)
# }

################################################################################
# AWS SSO Variables
################################################################################

variable "sso_admin_group_id" {
  description = "AWS_SSO Admin Group ID"
  type        = string
  sensitive   = true
  default     = "b4f8f4f8-e011-7046-0637-993dc10edd76"
}


# variable "ami_id" {
#   description = "The AMI ID for the instances"
#   type        = string
#   default     = "ami-03c983f9003cb9cd1"
# }

# variable "instance_type" {
#   description = "The instance type for the instances"
#   type        = string
#   default     = "t2.medium"
# }


# variable "key_name" {
#   description = "The key name for the instances"
#   type        = string
#   default     = "DevOps_key"
# }

# variable "s3_bucket" {
#   description = "The name of the S3 bucket for storing Terraform state"
#   type        = string
#   default     = "terraform-state-bucket-fusi"
# }

# variable "dynamodb_table" {
#   description = "The name of the DynamoDB table for state locking"
#   type        = string
#   default     = "terraform-lock-table"
# }
