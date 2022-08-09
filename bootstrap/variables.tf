variable "region" {
  description = "AWS region to use"
  type        = string
  default     = "us-east-1"
}

variable "ami_name" {
  type    = string
  default = "devEc2Inst"
}

variable "ami_id" {
  description = "AMI to use for dev instance"
  type        = string
  default     = "ami-090fa75af13c156b4" # Amazon linux
}

variable "ami_keypair" {
  description = "Keypair to use for EC2 instances"
  type        = string
  default     = "acloudkey"
}

variable "vpc_cidrblock" {
  description = "CIDR block to use for custom VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = string
    description = string
  }))
  default = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
      description = "ssh accesss"
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
      description = "http access"
    },
  ]
}
