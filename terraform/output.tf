output "sg-general-id" {
  value = "${aws_security_group.sg_general.id}"
}

output "uat-appserver-id" {
  value = "${aws_instance.uat-appserver.id}"
}

output "uat-appserver-pubdns" {
  value = "${aws_instance.uat-appserver.public_dns}"
}

output "uat-appserver-pubip" {
  value = "${aws_instance.uat-appserver.public_ip}"
}

output "uat-appserver-privip" {
  value = "${aws_instance.uat-appserver.private_ip}"
}