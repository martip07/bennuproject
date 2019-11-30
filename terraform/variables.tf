variable "aws_ak" {
  type        = string
  description = "Variable en la que se define el ACCESS KEY"
}

variable "aws_sk" {
  type        = string
  description = "Variable en la que se define el SECRET KEY"
}

variable "aws_region" {
  type        = string
  description = "Variable en la que se define la REGION en la que se va a trabajar"
}

variable "ec2_ami_id" {
  type        = string
  description = "Variable en la que se define el AMI ID"
}

variable "ec2_key_pub" {
  type        = string
  description = "Variable en la que se define la llave publica"
}

variable "ec2_key_priv" {
  type        = string
  description = "Variable en la que se define la llave privada"
}