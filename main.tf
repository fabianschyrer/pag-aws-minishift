provider "aws" {
  region = "eu-central-1"
}

##################################################################
# VPC, Subnet, Security Group and Amazon Machine Image (AMI)
##################################################################

data "aws_vpc" "pag-minishift" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = "${data.aws_vpc.pag-minishift.id}"
}

data "aws_ami" "centos" {
  most_recent = true

  owners = ["679593333241"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "name"
    values = ["CentOS Linux 7*"]
  }
}

module "security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "minishift-aws"
  description = "Security group for Minishift on AWS"
  vpc_id      = "${data.aws_vpc.default.id}"

  ingress_cidr_blocks = ["${var.access_ip}"]
  ingress_rules       = ["all-all"]
  egress_rules        = ["all-all"]
}

module "ec2" {
  source = "terraform-aws-modules/ec2-instance/aws"

  instance_count = 1

  name                        = "minishift-aws"
  key_name                    = "minishift-aws"
  ami                         = "${data.aws_ami.centos.id}"
  instance_type               = "${var.instance_type}"
  cpu_credits                 = "unlimited"
  subnet_id                   = "${element(data.aws_subnet_ids.all.ids, 0)}"
  vpc_security_group_ids      = ["${module.security_group.this_security_group_id}"]
  associate_public_ip_address = true

  root_block_device =  [{ "volume_size" = "${var.instance_rootfs_size}" }]
  
}

resource "aws_key_pair" "ec2_pubkey" {
  key_name   = "minishift-aws"
  public_key = "${file("${var.ssh_pubkey_path}")}"
}
