resource "aws_vpc" "stage1" {
  cidr_block           = var.vpc_cidrblock
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "stage1"
  }
}

# subnets.tf
resource "aws_subnet" "stage1_public" {
  cidr_block        = cidrsubnet(aws_vpc.stage1.cidr_block, 3, 1)
  vpc_id            = aws_vpc.stage1.id
  availability_zone = "us-east-1a"
  tags = {
    Name = "stage1_public"
  }
}

resource "aws_route_table" "stage1_public" {
  vpc_id = aws_vpc.stage1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.stage1.id
  }
  tags = {
    Name = "stage1_public"
  }
}

resource "aws_route_table_association" "subnet_association" {
  subnet_id      = aws_subnet.stage1_public.id
  route_table_id = aws_route_table.stage1_public.id
}

resource "aws_internet_gateway" "stage1" {
  vpc_id = aws_vpc.stage1.id
  tags = {
    Name = "stage1"
  }
}

resource "aws_security_group" "dev_inst" {
  name        = "allow_all_sg"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.stage1.id
  // Terraform removes the default rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "stage1_web_server_sg"
  }
}

resource "aws_security_group_rule" "ingress_rules" {
  count = length(var.ingress_rules)

  type              = "ingress"
  from_port         = var.ingress_rules[count.index].from_port
  to_port           = var.ingress_rules[count.index].to_port
  protocol          = var.ingress_rules[count.index].protocol
  cidr_blocks       = [var.ingress_rules[count.index].cidr_block]
  description       = var.ingress_rules[count.index].description
  security_group_id = aws_security_group.dev_inst.id
}

