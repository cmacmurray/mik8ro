# Make these your own, modules allow for little interpolation, so good luck!
provider "aws" { region = "${ var.aws["region"]  }"  }

variable "aws" {
default = {
    environment = "sandbox"
    provisioner = "terraform"
    account-id = "417474937029"
    azs = "us-east-1a,us-east-1b,us-east-1c,us-east-1e"
    key_name = "mik8ro-key"
    region = "us-east-1"
    public_key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCyo3zL8XqIq03s871jXFN5/mrUwOlwFBgyCQtFDyX+56nGoZgIVAi6KLjqkN1OAv4y0vSmPUaKBztykILyFZMVPY+0FUfMpQ98eYjYHgGmKcwYKQh7zjDybjfAWP60Gd4r7PZ9IfOIY1zl1AqX4clH+7+c9qS7hpqoTj3YZgaNx90NHeZarc1c/aCi3nN5jyLpdMC/6uKwYzBj8wsthJ7VhxJ6W/HaJ6eBP3lbETWUX0CXRL0pnzSADcFy3Hx7emluLczMPzCq0lD2xXaUliQ3p/eK00iH6IJf72KKMUkKfM1kTNGjUblzGgn+1pQBRS53zWnuTR+Rxdxzk4NyxuWT"
  
  }
}

variable "vpc" {
  default = {  
    vpc_name = "mik8ro"
    vpc_cidr = "10.0.0.0/16"
    enable_nat_gateway   = "true"
    enable_vpn_gateway   = "true"
  }
}

variable "network" {
  default = {
    trusted_cidr_blocks = ["108.176.26.122/32"] 
    private_subnets     = ["10.0.1.0/24",
                           "10.0.2.0/24",
                           "10.0.3.0/24"]
    public_subnets      = ["10.0.101.0/24",
                           "10.0.102.0/24",
                           "10.0.103.0/24"]
  }
}
