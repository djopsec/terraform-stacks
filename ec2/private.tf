resource "aws_instance" "demo" {
  ami                    = var.ami
  instance_type          = "t2.micro"
  vpc_security_group_ids = local.private_sg
  subnet_id              = local.private_subnets
  tags                   = local.tags
}