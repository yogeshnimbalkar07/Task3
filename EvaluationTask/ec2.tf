# ec2.tf

resource "aws_instance" "docker_hostY" {
  ami             = "ami-0e1d06225679bc1c5" # Amazon Linux 2 AMI (find latest in your region)
  instance_type   = "t2.micro" # Use appropriate instance type
  associate_public_ip_address = true
  key_name        = aws_key_pair.deployer.key_name
  subnet_id       = aws_subnet.main_subnetY.id
  security_groups = [aws_security_group.allow_ssh_httpY.id]

  user_data = <<-EOF
              #!/bin/bash
              # Update the package repository and install Docker
              yum update -y
              amazon-linux-extras install docker -y
              # Start Docker service
              service docker start
              # Add ec2-user to the docker group
              usermod -a -G docker ec2-user
              # Enable Docker to start on boot
              chkconfig docker on
              # Pull the Docker image from Docker Hub
              docker pull nginx:latest
              # Run the Docker container
              docker run -d -p 80:80 nginx:latest
            EOF

  tags = {
    Name = "docker_hostY"
  }
}
