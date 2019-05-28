resource "aws_key_pair" "mik8ro" {
  key_name = "mik8ro"
  public_key = "${var.aws["public_key_data"]}"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "v2.0"

  name                 = "${var.vpc["vpc_name"]}"
  cidr                 = "${var.vpc["vpc_cidr"]}"
  azs                  = ["us-east-1c", "us-east-1d", "us-east-1e"]
  private_subnets     = "${var.network["private_subnets"]}"
  public_subnets       = "${var.network["public_subnets"]}"
  enable_nat_gateway   = "${var.vpc["enable_nat_gateway"]}"
  enable_vpn_gateway   = "${var.vpc["enable_vpn_gateway"]}"
  tags = {
    Provisioner        = "${var.aws["provisioner"]}"
    Environment        = "${var.aws["environment"]}"
  }
}

output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

module "EKSControlPlaneSG" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "EKSControlPlaneSG"
  description = "Security group for EKS control plane"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress_cidr_blocks      = "${var.network["trusted_cidr_blocks"]}"
  ingress_with_cidr_blocks = [
    {
      from_port   = 443
      to_port     = 443 
      protocol    = "tcp"
      description = "EKSExternalControlPlaneSG"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "EKSExternalControlPlaneSG"
      cidr_blocks = "${var.vpc["vpc_cidr"]}"
    }
  ]
  egress_cidr_blocks  = ["0.0.0.0/0"]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "-1"
    }
  ]
}
