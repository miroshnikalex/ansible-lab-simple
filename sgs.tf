resource "aws_security_group" "ssh_management" {
  name		= "ssh_management"
  description	= "Allow SSH access to the resources"
  tags {
       Name = "ssh_management"
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

resource "aws_security_group" "web_management" {
  name		= "web_management"
  description	= "Allow HTTP/HTTPS access to the WEB servers"
  tags {
       Name = "web_management"
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
