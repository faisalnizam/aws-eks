resource "aws_db_subnet_group" "poc" {
  provider = aws.poc-dev
  name       = "poc-db-group"
  subnet_ids = ["${data.aws_subnet.poc-dev-sub-me-south-1-database-1a.id}", "${data.aws_subnet.poc-dev-sub-me-south-1-database-1b.id}"]

  tags = {
    Name = "SDP Prod DB subnet group"
  }
}


module "rds_instance" {
  source = "../../../modules/rds/"

  create            = var.create_db_instance
  identifier        = var.identifier
  engine            = var.engine
  engine_version    = var.engine_version
  instance_class    = var.db_instance_class
  allocated_storage = var.db_storage_capacity
  storage_type      = var.db_storage_type
  storage_encrypted = var.db_kms_key_id == "" ? "true" : "false"
  kms_key_id        = var.db_kms_key_id
  license_model     = var.license_model

  db_name                             = var.assign_db_name ? var.db_name : ""
  username                            = var.db_user_name
  password                            = var.db_password
  port                                = var.port
  iam_database_authentication_enabled = var.iam_database_authentication_enabled

  replicate_source_db = var.replicate_source_db

  snapshot_identifier = var.db_snapshot

  vpc_security_group_ids = var.vpc_security_group_ids //
  db_subnet_group_name   = aws_db_subnet_group.poc.id
  parameter_group_name   = module.rds_instance.db_parameter_group_id
  option_group_name      = module.rds_instance.db_option_group_id

  availability_zone   = var.availability_zone
  multi_az            = var.db_multi_az
  iops                = var.db_storage_type == "io1" ? var.db_storage_iops : 0
  publicly_accessible = var.publicly_accessible

  allow_major_version_upgrade = var.allow_major_version_upgrade
  auto_minor_version_upgrade  = var.auto_minor_version_upgrade
  apply_immediately           = var.apply_immediately
  maintenance_window          = var.maintenance_window
  skip_final_snapshot         = var.skip_final_snapshot
  copy_tags_to_snapshot       = var.copy_tags_to_snapshot
  final_snapshot_identifier   = var.final_snapshot_identifier

  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_retention_period

  backup_retention_period = var.db_backup_retention
  backup_window           = var.backup_window
  max_allocated_storage   = var.max_allocated_storage
  monitoring_interval     = var.monitoring_interval
  monitoring_role_arn     = var.monitoring_role_arn
  monitoring_role_name    = var.monitoring_role_name
  create_monitoring_role  = var.create_monitoring_role

  timezone                        = var.timezone
  character_set_name              = var.character_set_name
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  timeouts = var.timeouts

  deletion_protection = var.deletion_protection

  tags    = var.tags
  db_tags = var.db_tags


  #### Parameter Group Vars ####

  pg_name                = var.pg_name
  create_parameter_group = var.create_parameter_group
  description            = var.parameter_group_description
  family                 = var.family

  parameters = var.parameters

  pg_tags = {
    Name  = join("-", [var.label, var.environment])
    Owner = "Owner"
  }

  #### Option Group Vars ####

  create_option_group      = var.create_option_group
  name_prefix              = "${var.identifier}-"
  option_group_description = var.option_group_description
  engine_name              = var.engine_name
  major_engine_version     = var.major_engine_version

  og_tags = var.og_tags
}
