# vpc.tf

resource "aws_vpc" "main_vpcY" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "main_vpcY"
  }
}

resource "aws_subnet" "main_subnetY" {
  vpc_id            = aws_vpc.main_vpcY.id
  cidr_block        = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "ap-south-1a" # Change to your preferred availability zone
  tags = {
    Name = "main_subnetY"
  }
}

resource "aws_security_group" "allow_ssh_httpY" {
  vpc_id = aws_vpc.main_vpcY.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh_httpY"
  }
}
