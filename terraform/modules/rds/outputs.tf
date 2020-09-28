output "db_parameter_group_id" {
  description = "The db parameter group id"
  value       = element(concat(aws_db_parameter_group.main.*.id, [""]), 0)
}

output "db_parameter_group_arn" {
  description = "The ARN of the db parameter group"
  value       = element(concat(aws_db_parameter_group.main.*.arn, [""]), 0)
}

output "db_parameter_group_name" {
  description = "The name of the db parameter group"
  value       = element(concat(aws_db_parameter_group.main.*.name, [""]), 0)
}

output "db_option_group_id" {
  description = "The db option group id"
  value       = element(concat(aws_db_option_group.main.*.id, [""]), 0)
}

output "db_option_group_arn" {
  description = "The ARN of the db option group"
  value       = element(concat(aws_db_option_group.main.*.arn, [""]), 0)
}

output "db_option_group_name" {
  description = "The name of the db option group"
  value       = element(concat(aws_db_option_group.main.*.name, [""]), 0)
}

output "db_instance_address" {
  description = "The address of the RDS instance"
  value       = element(concat(aws_db_instance.main.*.address, [""]), 0)
}

output "db_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = element(concat(aws_db_instance.main.*.arn, [""]), 0)
}

output "db_instance_availability_zone" {
  description = "The availability zone of the RDS instance"
  value       = element(concat(aws_db_instance.main.*.availability_zone, [""]), 0)
}

output "db_instance_endpoint" {
  description = "The connection endpoint"
  value       = element(concat(aws_db_instance.main.*.endpoint, [""]), 0)
}

output "db_instance_hosted_zone_id" {
  description = "The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record)"
  value       = element(concat(aws_db_instance.main.*.hosted_zone_id, [""]), 0)
}

output "db_instance_id" {
  description = "The RDS instance ID"
  value       = element(concat(aws_db_instance.main.*.id, [""]), 0)
}

output "db_instance_resource_id" {
  description = "The RDS Resource ID of this instance"
  value       = element(concat(aws_db_instance.main.*.resource_id, [""]), 0)
}

output "db_instance_status" {
  description = "The RDS instance status"
  value       = element(concat(aws_db_instance.main.*.status, [""]), 0)
}

output "db_instance_name" {
  description = "The database name"
  value       = element(concat(aws_db_instance.main.*.name, [""]), 0)
}

output "db_instance_username" {
  description = "The master username for the database"
  value       = element(concat(aws_db_instance.main.*.username, [""]), 0)
}

output "db_instance_port" {
  description = "The database port"
  value       = element(concat(aws_db_instance.main.*.port, [""]), 0)
}
