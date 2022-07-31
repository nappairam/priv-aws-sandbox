variable "region" {
  description = "AWS region to use"
  type        = string
  default     = "us-east-1"
}

variable "s3website" {
  description = "Bucket name to serve Website files"
  type        = string
}
