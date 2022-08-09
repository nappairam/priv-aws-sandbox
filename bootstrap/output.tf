data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}


data "aws_eip" "dev_inst" {
  id = aws_eip.dev_inst.id
}

output "dev_inst_ip" {
  value = data.aws_eip.dev_inst.public_ip
}

data "aws_instance" "dev_inst" {
  instance_id = aws_instance.dev_inst.id
}

output "dev_inst_dns" {
  description = "DNS of dev ec2 instance"
  value = data.aws_eip.dev_inst.public_dns
}
