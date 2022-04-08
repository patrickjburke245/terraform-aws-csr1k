# Terraform CSR 1000v on AWS

Terraform module to deploy CSR 1000v on AWS

## Deploy CSR 1000v to existing VPC

```hcl
module "csr1k" {
  source  = "bayupw/csr1k/aws"
  version = "1.0.0"

  vpc_id = "vpc-0a1b2c3d4e"
  gi0_subnet_id = "subnet-0a1b2c3d4e"
  gi1_subnet_id = "subnet-1b2c3d4e5f"
  key_name = "ec2-keypair"
}
```

## Create a new VPC and Deploy CSR 1000v into it

```hcl
module "csr_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name                 = "csr-vpc"
  cidr                 = "10.0.0.0/16"
  azs                  = ["ap-southeast-2a"]
  private_subnets      = ["10.0.1.0/24"]
  public_subnets       = ["10.0.101.0/24"]
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "csr-vpc"
  }
}

module "csr1k" {
  source  = "bayupw/csr1k/aws"
  version = "1.0.0"

  vpc_id = module.csr_vpc.id
  gi0_subnet_id = "module.csr_vpc.public_subnets[0]
  gi1_subnet_id = module.csr_vpc.private_subnets[0]
  key_name = "ec2-keypair"
}
```

## Contributing

Report issues/questions/feature requests on in the [issues](https://github.com/bayupw/terraform-aws-csr1k/issues/new) section.

## License

Apache 2 Licensed. See [LICENSE](https://github.com/bayupw/terraform-aws-csr1k/tree/master/LICENSE) for full details.