output "instance_public_ip" {
  value       = aws_instance.public_vm.public_ip
}

output "vpc_id" {
  value       = aws_vpc.vpc.id
}
