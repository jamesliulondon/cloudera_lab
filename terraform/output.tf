output "addresses" {
  #value = ["Nuke!"]
  #value = ["${format("%s %s %s %s", "${lookup(var.sample_hostnames, concat("name", index))}","${aws_instance.cdh.*.public_dns}", "${aws_instance.cdh.*.public_ip}","${aws_instance.cdh.*.private_ip}")}"]
  value = ["${format("%s %s %s", "${aws_instance.cdh.*.public_dns}", "${aws_instance.cdh.*.public_ip}", "${aws_instance.cdh.*.private_ip}")}"]
}
