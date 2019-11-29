resource "aws_security_group" "sg_general" {
  name        = "sg_general_uat"
  description = "General security group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Rule for SSH conections"
  }

  tags = {
    Name = "sg_general_uat"
    Env  = "uat"
  }
}
