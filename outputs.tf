output "ids" {
  description = "AWS instance IDs:"
  value       = "${module.ec2.id}"
}

output "public_dns" {
  description = "Public DNS names assigned to instances:"
  value       = "${module.ec2.public_dns}"
}

output "vpc_security_group_ids" {
  description = "AWS VPC Security Group IDs assigned to instances:"
  value       = "${module.ec2.vpc_security_group_ids}"
}

output "tags" {
  description = "Assined Tags:"
  value       = "${module.ec2.tags}"
}

output "instance_id" {
  description = "EC2 instance ID:"
  value       = "${module.ec2.id[0]}"
}

output "instance_public_dns" {
  description = "Public DNS name assigned to EC2 instance:"
  value       = "${module.ec2.public_dns[0]}"
}

output "instance_public_ip" {
  description = "Public IP Address assigned to EC2 instance:"
  value       = "${module.ec2.public_ip[0]}"
}

output "credit_specification" {
  description = "Credit Specification of EC2 instance (empty list for not t2 instance types)"
  value       = "${module.ec2.credit_specification}"
}
