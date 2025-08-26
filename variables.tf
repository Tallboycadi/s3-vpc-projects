variable "region" {
  type    = string
  default = "us-east-1"
}

variable "project_name" {
  type        = string
  description = "Project name prefix for resources"
  default     = "clif-aws-vpc-s3"
}

variable "cidr_block" {
  type        = string
  description = "VPC CIDR"
  default     = "10.20.0.0/16"
}