resource "aws_instance" "dev_inst" {
  ami                    = var.ami_id
  instance_type          = "t3.medium"
  availability_zone      = "us-east-1a"
  key_name               = var.ami_keypair
  vpc_security_group_ids = ["${aws_security_group.dev_inst.id}"]
  user_data              = file("static_files/installDocker.sh")
  subnet_id              = aws_subnet.stage1_public.id
  tags = {
    Name = var.ami_name
  }
}

resource "aws_eip" "dev_inst" {
  instance = aws_instance.dev_inst.id
  vpc      = true
}

