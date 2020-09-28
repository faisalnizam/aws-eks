resource "aws_db_parameter_group" "main" {
  count = var.create_parameter_group ? 1 : 0

  name        = var.pg_name
  description = coalesce(var.description, "Database parameter group for ${var.identifier}")
  family      = var.family

  dynamic "parameter" {
    for_each = var.parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = lookup(parameter.value, "apply_method", null)
    }
  }

  tags = merge(
    var.tags,
    {
      "Name" = format("%s", var.pg_name)
    },
    var.pg_tags,
  )

  lifecycle {
    create_before_destroy = true
  }
}