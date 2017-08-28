resource "aws_security_group" "allow_ssh" {
  name		= "allow_ssh"
  description	= "Allow SSH access to the resources"
  tags {
       Name = "allow_ssh"
       Group = "management"
       }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks  = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow_web" {
  name		= "allow_web"
  description	= "Allow HTTP/HTTPS access to the WEB servers"
  tags {
       Name = "allow_web"
       Group = "Service"
       }

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks  = ["0.0.0.0/0"]
}
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
