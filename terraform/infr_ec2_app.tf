resource "aws_instance" "uat-appserver" {
  ami                    = "${var.ec2_ami_id}"
  instance_type          = "t2.micro"
  vpc_security_group_ids = "${aws_security_group.sg_general.*.id}"
  key_name = "${aws_key_pair.key_deployguy.id}"

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y install python",
      "sudo apt-get -y install software-properties-common",
      "sudo apt-add-repository ppa:ansible/ansible -y",
      "sudo apt-get update",
      "sudo apt-get -y install ansible"
    ]

    connection {
      type = "ssh"
      user = "ubuntu"
      host = self.public_ip
      private_key = "${file("${path.module}/tmp/tempkey")}"
    }
  }

  provisioner "file" {
    source = "../ansible/"
    destination = "/tmp"

    connection {
      type = "ssh"
      user = "ubuntu"
      host = self.public_ip
      private_key = "${var.ec2_key_priv}"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "ansible-playbook /tmp/infratask.yml -v",
    ]

    connection {
      type = "ssh"
      user = "ubuntu"
      host = self.public_ip
      private_key = "${var.ec2_key_priv}"
    }
  }

  tags = {
    Name = "${var.ec2_name}"
  }
}