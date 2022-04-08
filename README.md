# Terraform CSR 1000v on AWS

Terraform module to deploy CSR 1000v on AWS

## Deploy on existing VPC

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

## Contributing

Report issues/questions/feature requests on in the [issues](https://github.com/bayupw/terraform-aws-csr1k/issues/new) section.

## License

Apache 2 Licensed. See [LICENSE](https://github.com/bayupw/terraform-aws-csr1k/tree/master/LICENSE) for full details.