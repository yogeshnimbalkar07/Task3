# outputs.tf

output "instance_public_ip" {
  value = [aws_instance.docker_hostY.*.public_ip]
}
