provider "aws" {
  access_key = "${var.aws_ak}"
  secret_key = "${var.aws_sk}"
  region     = "${var.aws_region}"
}
