resource "aws_key_pair" "acloudkey" {
  key_name   = var.ami_keypair
  public_key = file("static_files/acloudkey.pub")
}
