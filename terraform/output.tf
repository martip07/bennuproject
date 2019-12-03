output "sg-general-id" {
  value = "${aws_security_group.sg_general.id}"
}

output "appserver-id" {
  value = "${aws_instance.uat-appserver.id}"
}

output "appserver-pubdns" {
  value = "${aws_instance.uat-appserver.public_dns}"
}

output "appserver-pubip" {
  value = "${aws_instance.uat-appserver.public_ip}"
}

output "appserver-privip" {
  value = "${aws_instance.uat-appserver.private_ip}"
}