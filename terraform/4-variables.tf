variable "region" {
  type = string
  description = "AWS region"
  default  = "us-east-1"
}

variable "VPC_CIDR" {
    description = "Cidr for the VPC"
    type = string
    default = "10.0.0.0/16"
}


variable "cluster_name" {
    description = "Name of the cluster"
    type = string
    default = "Feedback-app"
}


variable "private_subnet_cidr" {
    description = "Cidr for the private subnet"
    type = list(string)
    default = [ "10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24" ]
    }



variable "public_subnet_cidr" {
    description = "Cidr for the public subnet"
    type = list(string)
    default = [ "10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"  ]
}


variable "Availability_Zones" {
    description = "Availability zones"
    type = list(string)
    default = [ "us-east-1a","us-east-1b","us-east-1c" ]
}