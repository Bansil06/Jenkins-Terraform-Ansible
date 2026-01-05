variable "aws_region" {
  default = "ap-south-1"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "key_name" {
  description = "Existing AWS key pair"
}

variable "ami_id" {
  default = "ami-0f58b397bc5c1f2e8"
}
