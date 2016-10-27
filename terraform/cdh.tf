resource "template_file" "cdh_init" {
  count    = "${var.cdh_nodes}"
  template  = "${file("cloud-init/hadoopnodeprep.yml")}"
  vars  {
    tf_hostname = "${lookup(var.sample_hostnames, count.index, "localhost.localdomain")}"
  }
}

resource "aws_instance" "cdh" {

  associate_public_ip_address = true
  count           =  "${var.cdh_nodes}"
  ami             =  "${var.ami}"
  instance_type   =  "t2.nano"
  key_name        =  "${var.key_name}"
  instance_type   =  "${var.instance_type}"
  security_groups =  ["${aws_security_group.sg_cdh.id}"]

  subnet_id       =  "${element(aws_subnet.public_subnets.*.id,    (count.index + 1)%3)}"
  user_data       =  "${element(template_file.cdh_init.*.rendered, count.index)}"

  
  tags {
    Name = "${var.project}-${var.environment}-cdh${count.index}"
    Environment = "${var.environment}"
    Project = "${var.project}"
   }

  connection {
    type = "ssh"
    user = "ec2-user"
    #private_key = "/Users/james.liu/code/repo/sshkey/21apr.key"
    private_key = "${var.my_rootdir}/.ssh/${var.local_key_file}"
  }

  provisioner "file" {
    source = "templates/training_public_key"
    destination = "/tmp/training_public_key"
  }

  provisioner "file" {
    source = "templates/id_rsa"
    destination = "/tmp/id_rsa"
  }

  provisioner "file" {
    source = "templates/sudofile"
    destination = "/tmp/sudofile"
  }

  provisioner "file" {
    source = "templates/cloudera-manager.repo"
    destination = "/tmp/cloudera-manager.repo"
  }

  provisioner "file" {
    source = "templates/cloudera-cm5.repo"
    destination = "/tmp/cloudera-cm5.repo"
  }


}
