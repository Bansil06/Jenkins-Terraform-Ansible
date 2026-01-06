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


################## Clean Up Existing Inventory File ################## 
resource "null_resource" "clean_up" {
  provisioner "local-exec" {
    when    = destroy
    command = "rm -rf ../static_inventory"
  }
}

################## Create static inventory ################## 
resource "null_resource" "generate_static_inventory" {
  provisioner "local-exec" {
    command = <<EOT
cat <<EOF > static_inventory
${templatefile("${path.module}/static-inventory-template.tpl", {
  ubuntu = aws_instance.web[*].public_ip
})}
EOF
EOT
  }

  depends_on = [
    aws_instance.web
  ]
}
