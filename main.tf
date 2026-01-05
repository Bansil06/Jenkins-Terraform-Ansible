data "aws_security_group" "existing_sg" {
  id = "sg-0b724ef2b7afbbc1a"
}

resource "aws_instance" "web" {
  count                  = 2
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [data.aws_security_group.existing_sg.id]

  tags = {
    Name = "Jenkins-Terraform-${count.index}"
  }
}
