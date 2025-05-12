variable "region" {
  type = string
  description = "The AWS region to deploy to"
  default  = "us-east-1"
}

variable "cluster_name" {
  type = string
  description = "The name of the EKS cluster"
  
}

variable "vpc_id" {
  type = string
  description = "The VPC ID to deploy to"
}

variable "subnet_ids" {
  type = list(string)

  
}