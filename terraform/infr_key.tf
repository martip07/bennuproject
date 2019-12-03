resource "aws_key_pair" "key_deployguy" {
    key_name = "key_deployguy"
    public_key = "${var.ec2_key_pub}"
}
