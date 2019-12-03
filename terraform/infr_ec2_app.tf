resource "aws_instance" "uat-appserver" {
  ami                    = "${var.ec2_ami_id}"
  instance_type          = "t2.micro"
  vpc_security_group_ids = "${aws_security_group.sg_general.*.id}"

  tags = {
    Name = "${var.ec2_name}"
  }
}
