

variable "ami_id" {}
variable "mtc_security_id" {}
variable "mtc_public_subnet_id" {}
variable "key_pair_id" {}

resource "aws_instance" "dev_node" {
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  subnet_id              = var.mtc_public_subnet_id
  key_name               = var.key_pair_id
  vpc_security_group_ids = [var.mtc_security_id]
  user_data = file("${path.module}/userdata.tpl")

  root_block_device {
    volume_size = 12
  }

  tags = {
    Name = "dev-node"
  }

  provisioner "local-exec" {
    command = templatefile("${path.module}/${var.host_os}-ssh-config.tpl", {
      hostname = self.public_ip,
      user = "ubuntu",
      identityfile = "/.ssh/mtc_key"
    })
    interpreter = ["bash", "-c"]
  }
}
