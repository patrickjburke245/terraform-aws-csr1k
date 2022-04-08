module "onprem_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name                 = "onprem-vpc"
  cidr                 = "10.0.0.0/16"
  azs                  = ["ap-southeast-2a", "ap-southeast-2b"]
  private_subnets      = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets       = ["10.0.101.0/24", "10.0.102.0/24"]
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "onprem-vpc"
  }
}

data "aws_route_table" "private_subnet_rtb" {
  subnet_id = module.onprem_vpc.private_subnets[0]

  depends_on = [module.onprem_vpc]
}

resource "aws_route" "route_via_csr" {
  route_table_id         = data.aws_route_table.private_subnet_rtb.route_table_id
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id   = aws_network_interface.csr_gi1.id

  depends_on = [module.onprem_vpc, aws_instance.this]
}