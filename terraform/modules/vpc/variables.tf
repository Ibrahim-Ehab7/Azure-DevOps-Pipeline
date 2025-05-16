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
    }



variable "public_subnet_cidr" {
    description = "Cidr for the public subnet"
    type = list(string)
}


variable "Availability_Zones" {
    description = "Availability zones"
    type = list(string)
}



