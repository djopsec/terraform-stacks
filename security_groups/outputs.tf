output "public_security_group_id" {
  description = "SSH Security Groups ID for the VPC"
  value       = "${aws_security_group.public_https.id}"
}

output "all_private_security_group_id" {
  description = "Private Security Groups ID for the VPC"
  value       = "${aws_security_group.all_private.id}"
}

output "vpc_region" {
  description = "VPC region for security groups"
  value       = "${data.terraform_remote_state.vpc.outputs.vpc_region}"
}

output "vpc_id" {
  description = "VPC id for security groups"
  value       = "${data.terraform_remote_state.vpc.outputs.vpc_id}"
}