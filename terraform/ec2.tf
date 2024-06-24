resource "aws_security_group" "strapi-sg" {
  vpc_id      = aws_vpc.strapi_vpc.id
  description = "Security Group for Strapi Application"
  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {

    from_port   = "1337"
    to_port     = "1337"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {

    from_port   = "5432"
    to_port     = "5432"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name = "Strapi-SG"
  }

}

resource "aws_instance" "strapi-ec2" {
  ami                         = var.ami
  instance_type               = "t2.medium"
  vpc_security_group_ids      = [aws_security_group.strapi-sg.id]
  subnet_id                   = aws_subnet.public_subnet1.id
  key_name                    = "PEM-NV"
  associate_public_ip_address = true
  user_data                   = <<-EOF
                                #!/bin/bash
                                sudo apt update && sudo apt install docker.io docker-compose -y
                                sudo systemctl enable docker && sudo usermod -aG docker $USER 
                                git clone https://github.com/arunkumaar-r/Strapi-Docker.git
                                cd Strapi-Docker
                                docker-compose up -d
                                sleep 2000
                                EOF

  tags = {
    Name = "Strapi_ec2"
  }
}

