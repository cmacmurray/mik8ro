#resource "aws_key_pair" "mik8ro" {
#  name = "mik8ro"
#  public_key = "${var.aws[public_key_data]}"
#}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name                 = "${var.vpc["vpc_name"]}"
  cidr                 = "${var.vpc["vpc_cidr"]}"
  azs                  = ["us-east-1c", "us-east-1d", "us-east-1e"]
  private_subnets      = ["${var.network["private_subnets"]}"]
  public_subnets       = ["${var.network["public_subnets"]}"]
  enable_nat_gateway   = "${var.vpc["enable_nat_gateway"]}"
  enable_vpn_gateway   = "${var.vpc["enable_vpn_gateway"]}"
  tags = {
    Provisioner        = "${var.aws["provisioner"]}"
    Environment        = "${var.aws["environment"]}"
  }

}
