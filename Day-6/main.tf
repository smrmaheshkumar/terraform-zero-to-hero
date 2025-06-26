provider "aws" {
  region = "us-east-1"
}

variable "ami" {
  description = "value"
}

variable "instance_type" {
  description = "value"
  type = map(string)

  default = {
    "dev" = "t2.micro"
    "stage" = "t2.medium"
    "prod" = "t2.xlarge"
  }
}

module "ec2_instance" {
  source = "./modules/ec2_instance"
  ami = var.ami
  instance_type = lookup(var.instance_type, terraform.workspace, "t2.micro")
}

#   instance_type = lookup(var.instance_type, terraform.workspace, "t2.micro")
# In the above line. lookup will see terraform.workspace is prod or stage or dev (terraform workspace set prod) then select based on workspace. If no workspace present the select default t2.micro
