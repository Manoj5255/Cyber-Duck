output "rds_endpoint" {
  description = "The endpoint of the created RDS instance"
  value       = aws_db_instance.rds_instance.endpoint
}
