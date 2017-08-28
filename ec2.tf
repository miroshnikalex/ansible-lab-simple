provider "aws" {
  region = "${var.AWS_REGION}"
  profile = "${var.AWS_PROFILE_NAME}"
}

# Setting up WEB servers

resource "aws_instance" "web-server" {
    count = "${var.AWS_COUNT_WEB}"
    availability_zone = "${element(var.AVZ[var.AWS_REGION], count.index)}"
    ami = "${lookup(var.AWS_AMI,var.AWS_REGION)}"
    key_name = "${var.AWS_KEY_NAME}"
    instance_type = "${var.AWS_INSTANCE_TYPE}"
    associate_public_ip_address = "true"
    vpc_security_group_ids = [
      "${aws_security_group.ssh_management.id}",
      "${aws_security_group.web_management.id}"
    ]
  tags {
    Name = "web-server-${count.index}"
    Role = "Web_Server"
       }
  provisioner "file" {
    source = ".ssh/ansible-key.pub"
         destination = "/tmp/ansible-key.pub"
         connection {
           type = "ssh"
           user = "ec2-user"
           private_key = "${file(".ssh/aws_ec2_Alex")}"
           }
       }
  provisioner "file" {
    source = "files/ansible-user-sudoers"
    destination = "/tmp/ansible-user-sudoers"
    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = "${file("~/terraform/.ssh/aws_ec2_Alex")}"
        }
  }
  provisioner "remote-exec" {
    inline = [
      "sudo useradd -d /home/ansible-user -m -p $(echo '${var.ANSIBLE_PASSWORD}' | openssl passwd -1 -stdin) ansible-user",
      "sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config",
      "sudo sed -i 's/#   StrictHostKeyChecking ask/StrictHostKeyChecking no/g' /etc/ssh/ssh_config",
      "sudo systemctl reload sshd",
      "sudo mv /tmp/ansible-user-sudoers /etc/sudoers.d",
      "sudo chown root:root /etc/sudoers.d/ansible-user-sudoers",
      "sudo chmod 440 /etc/sudoers.d/ansible-user-sudoers",
      "sudo -u ansible-user mkdir /home/ansible-user/.ssh",
      "sudo mv /tmp/ansible-key.pub /home/ansible-user/.ssh/authorized_keys",
      "sudo chown ansible-user:ansible-user /home/ansible-user/.ssh/authorized_keys",
      "sudo -u ansible-user chmod 700 /home/ansible-user/.ssh",
      "sudo -u ansible-user chmod 400 /home/ansible-user/.ssh/authorized_keys"
             ]
  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = "${file(".ssh/aws_ec2_Alex")}"
    }
  }
}

# Setting up DB server

resource "aws_instance" "db-server" {
    count = "${var.AWS_COUNT_DB}"
    availability_zone = "${element(var.AVZ[var.AWS_REGION], count.index)}"
    ami = "${lookup(var.AWS_AMI,var.AWS_REGION)}"
    key_name = "${var.AWS_KEY_NAME}"
    instance_type = "${var.AWS_INSTANCE_TYPE}"
    associate_public_ip_address = "true"
    vpc_security_group_ids = [
      "${aws_security_group.ssh_management.id}"
    ]
  tags {
    Name = "db-server-${count.index}"
    Role = "DB_Server"
       }
  provisioner "file" {
    source = ".ssh/ansible-key.pub"
         destination = "/tmp/ansible-key.pub"
         connection {
           type = "ssh"
           user = "ec2-user"
           private_key = "${file(".ssh/aws_ec2_Alex")}"
           }
       }
  provisioner "file" {
    source = "files/ansible-user-sudoers"
    destination = "/tmp/ansible-user-sudoers"
    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = "${file("~/terraform/.ssh/aws_ec2_Alex")}"
        }
  }
  provisioner "remote-exec" {
    inline = [
      "sudo useradd -d /home/ansible-user -m -p $(echo '${var.ANSIBLE_PASSWORD}' | openssl passwd -1 -stdin) ansible-user",
      "sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config",
      "sudo sed -i 's/#   StrictHostKeyChecking ask/StrictHostKeyChecking no/g' /etc/ssh/ssh_config",
      "sudo systemctl reload sshd",
      "sudo mv /tmp/ansible-user-sudoers /etc/sudoers.d",
      "sudo chown root:root /etc/sudoers.d/ansible-user-sudoers",
      "sudo chmod 440 /etc/sudoers.d/ansible-user-sudoers",
      "sudo -u ansible-user mkdir /home/ansible-user/.ssh",
      "sudo mv /tmp/ansible-key.pub /home/ansible-user/.ssh/authorized_keys",
      "sudo chown ansible-user:ansible-user /home/ansible-user/.ssh/authorized_keys",
      "sudo -u ansible-user chmod 700 /home/ansible-user/.ssh",
      "sudo -u ansible-user chmod 400 /home/ansible-user/.ssh/authorized_keys"
             ]
  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = "${file(".ssh/aws_ec2_Alex")}"
    }
  }
}

# Setting up LB servers

resource "aws_instance" "lb" {
    count = "${var.AWS_COUNT_LB}"
    availability_zone = "${element(var.AVZ[var.AWS_REGION], count.index)}"
    ami = "${lookup(var.AWS_AMI,var.AWS_REGION)}"
    key_name = "${var.AWS_KEY_NAME}"
    instance_type = "${var.AWS_INSTANCE_TYPE}"
    associate_public_ip_address = "true"
    vpc_security_group_ids = [
      "${aws_security_group.ssh_management.id}"
    ]
  tags {
    Name = "lb-${count.index}"
    Role = "Load_Balancer"
       }
  provisioner "file" {
    source = ".ssh/ansible-key.pub"
         destination = "/tmp/ansible-key.pub"
         connection {
           type = "ssh"
           user = "ec2-user"
           private_key = "${file(".ssh/aws_ec2_Alex")}"
           }
       }
  provisioner "file" {
    source = "files/ansible-user-sudoers"
    destination = "/tmp/ansible-user-sudoers"
    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = "${file("~/terraform/.ssh/aws_ec2_Alex")}"
        }
  }
  provisioner "remote-exec" {
    inline = [
      "sudo useradd -d /home/ansible-user -m -p $(echo '${var.ANSIBLE_PASSWORD}' | openssl passwd -1 -stdin) ansible-user",
      "sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config",
      "sudo sed -i 's/#   StrictHostKeyChecking ask/StrictHostKeyChecking no/g' /etc/ssh/ssh_config",
      "sudo systemctl reload sshd",
      "sudo mv /tmp/ansible-user-sudoers /etc/sudoers.d",
      "sudo chown root:root /etc/sudoers.d/ansible-user-sudoers",
      "sudo chmod 440 /etc/sudoers.d/ansible-user-sudoers",
      "sudo -u ansible-user mkdir /home/ansible-user/.ssh",
      "sudo mv /tmp/ansible-key.pub /home/ansible-user/.ssh/authorized_keys",
      "sudo chown ansible-user:ansible-user /home/ansible-user/.ssh/authorized_keys",
      "sudo -u ansible-user chmod 700 /home/ansible-user/.ssh",
      "sudo -u ansible-user chmod 400 /home/ansible-user/.ssh/authorized_keys"
             ]
  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = "${file(".ssh/aws_ec2_Alex")}"
    }
  }
}
