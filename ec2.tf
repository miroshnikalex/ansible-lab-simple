provider "aws" {
  region = "${var.AWS_REGION}"
  profile = "${var.AWS_PROFILE_NAME}"
}

resource "aws_instance" "web-server" {
    count = "${var.AWS_COUNT_WEB}"
    availability_zone = "${element(var.AVZ[var.AWS_REGION], count.index)}"
    ami = "${lookup(var.AWS_AMI,var.AWS_REGION)}"
    key_name = "${var.AWS_KEY_NAME}"
    instance_type = "${var.AWS_INSTANCE_TYPE}"
    associate_public_ip_address = "true"
    vpc_security_group_ids = [
      "${aws_security_group.allow_ssh.id}",
      "${aws_security_group.allow_web.id}"
    ]
  tags {
    Name = "web-server-${count.index}"
    Role = "Web_Server"
       }
  provisioner "remote-exec" {
    inline = [
      "sudo rpm -Uhv https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm",
      "sudo yum clean all",
      "sudo yum install vim mc -y"
             ]
  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = "${file(".ssh/aws_ec2_Alex")}"
    }
  }
}

provider "aws" {
  region = "${var.AWS_REGION}"
  profile = "${var.AWS_PROFILE_NAME}"
}

resource "aws_instance" "db-server" {
    count = "${var.AWS_COUNT_DB}"
    availability_zone = "${element(var.AVZ[var.AWS_REGION], count.index)}"
    ami = "${lookup(var.AWS_AMI,var.AWS_REGION)}"
    key_name = "${var.AWS_KEY_NAME}"
    instance_type = "${var.AWS_INSTANCE_TYPE}"
    associate_public_ip_address = "true"
    vpc_security_group_ids = [
      "${aws_security_group.allow_ssh.id}"
    ]
  tags {
    Name = "db-server-${count.index}"
    Role = "DB_Server"
       }
  provisioner "remote-exec" {
    inline = [
      "sudo rpm -Uhv https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm",
      "sudo yum clean all",
      "sudo yum install vim mc -y"
             ]
  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = "${file(".ssh/aws_ec2_Alex")}"
    }
  }
}

resource "aws_instance" "lb" {
    count = "${var.AWS_COUNT_DB}"
    availability_zone = "${element(var.AVZ[var.AWS_REGION], count.index)}"
    ami = "${lookup(var.AWS_AMI,var.AWS_REGION)}"
    key_name = "${var.AWS_KEY_NAME}"
    instance_type = "${var.AWS_INSTANCE_TYPE}"
    associate_public_ip_address = "true"
    vpc_security_group_ids = [
      "${aws_security_group.allow_ssh.id}"
    ]
  tags {
    Name = "Load_Balancer"
       }
  provisioner "remote-exec" {
    inline = [
      "sudo rpm -Uhv https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm",
      "sudo yum clean all",
      "sudo yum install vim mc -y"
             ]
  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = "${file(".ssh/aws_ec2_Alex")}"
    }
  }
}
