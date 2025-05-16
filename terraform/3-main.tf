module "vpc" {
    source = "./modules/vpc"
    VPC_CIDR             =  var.VPC_CIDR    
    cluster_name         =  var.cluster_name
    private_subnet_cidr  =  var.private_subnet_cidr
    public_subnet_cidr   =  var.public_subnet_cidr
    Availability_Zones   =  var.Availability_Zones
}