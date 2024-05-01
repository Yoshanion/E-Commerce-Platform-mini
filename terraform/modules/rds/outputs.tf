output "db_instance_endpoint" {
  value       = aws_db_subnet_group.default.address
}

output "db_instance_id" {
  value       = aws_db_instance.default.id
}
