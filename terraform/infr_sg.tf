resource "aws_security_group" "sg_general" {
  name        = "${var.ec2_sg_name}"
  description = "General security group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Rule for SSH conections"
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Egress for everything"
  }

  tags = {
    Name = "${var.ec2_sg_name}"
  }
}