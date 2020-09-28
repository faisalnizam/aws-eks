#################################
#### DB Parameter Group Vars ####
#################################
variable "create_parameter_group" {
  description = "Whether to create this resource or not?"
  type        = bool
  default     = true
}

variable "family" {
  description = "The family of the DB parameter group"
  type        = string
  default     = "postgres9.6"
}

variable "pg_name" {
  description = "Name of the DB parameter group"
  type        = string
  default     = "test"
}

variable "parameters" {
  description = "A list of maps of DB parameter to apply"
  type        = list(map(string))
  default = [
    {
      name  = "log_statement"
      value = "all"
    },
    {
      name  = "log_min_duration_statement"
      value = "500"
    }
  ]
}

variable "parameter_group_description" {
  description = "A parameter group for description"
  type        = string
  default     = "A parameter group for postgres"
}

variable "pg_tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

##############################
#### DB Option Group Vars ####
##############################
variable "create_option_group" {
  description = "Whether to create this resource or not?"
  type        = bool
  default     = false
}

variable "option_group_description" {
  description = "The description of the option group"
  type        = string
  default     = ""
}

variable "engine_name" {
  description = "Specifies the name of the engine that this option group should be associated with"
  type        = string
  default     = ""
}

variable "major_engine_version" {
  description = "Specifies the major version of the engine that this option group should be associated with"
  type        = string
  default     = ""
}

variable "options" {
  description = "A list of Options to apply"
  type        = any
  default     = []
}

variable "og_tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

##########################
#### DB Instance Vars ####
##########################
variable "create_db_instance" {
  description = "Whether to create this resource or not?"
  type        = bool
  default     = true
}

variable "identifier" {
  description = "The name of the RDS instance, if omitted, Terraform will assign a random, unique identifier"
  type        = string
}

variable "engine" {
  description = "The database engine to use"
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "The engine version to use"
  type        = string
  default     = "9.6"
}

variable "license_model" {
  description = "License model information for this DB instance. Optional, but required for some DB engines, i.e. Oracle SE1"
  type        = string
  default     = ""
}

variable "port" {
  description = "The port on which the DB accepts connections"
  type        = string
  default     = "3306"
}

variable "replicate_source_db" {
  description = "Specifies that this resource is a Replicate database, and to use this value as the source database. This correlates to the identifier of another Amazon RDS Database to replicate."
  type        = string
  default     = ""
}

variable "iam_database_authentication_enabled" {
  description = "Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled"
  type        = bool
  default     = false
}

variable "publicly_accessible" {
  description = "Bool to control if instance is publicly accessible"
  type        = bool
  default     = true
}

variable "allow_major_version_upgrade" {
  description = "Indicates that major version upgrades are allowed. Changing this parameter does not result in an outage and the change is asynchronously applied as soon as possible"
  type        = bool
  default     = true
}

variable "auto_minor_version_upgrade" {
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window"
  type        = bool
  default     = true
}

variable "apply_immediately" {
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
  type        = bool
  default     = false
}

variable "maintenance_window" {
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'"
  type        = string
  default     = "mon:02:00-mon:02:30"
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted, using the value from final_snapshot_identifier"
  type        = bool
  default     = true
}

variable "copy_tags_to_snapshot" {
  description = "On delete, copy all Instance tags to the final snapshot (if final_snapshot_identifier is specified)"
  type        = bool
  default     = true
}

variable "db_backup_retention" {
  description = "The days to retain backups for"
  type        = number
  default     = 10
}

variable "backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window"
  type        = string
  default     = "00:00-00:30"
}

variable "availability_zone" {
  description = "The Availability Zone of the RDS instance"
  type        = string
  default     = ""
}

variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate"
  type        = list(string)
  default     = []
}

variable "final_snapshot_identifier" {
  description = "The name of your final DB snapshot when this DB instance is deleted."
  type        = string
  default     = null
}

variable "performance_insights_enabled" {
  description = "Specifies whether Performance Insights are enabled"
  type        = bool
  default     = false
}

variable "performance_insights_retention_period" {
  description = "The amount of time in days to retain Performance Insights data. Either 7 (7 days) or 731 (2 years)."
  type        = number
  default     = 7
}

variable "max_allocated_storage" {
  description = "Specifies the value for Storage Autoscaling"
  type        = number
  default     = 0
}

variable "monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60."
  type        = number
  default     = 0
}

variable "monitoring_role_arn" {
  description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. Must be specified if monitoring_interval is non-zero."
  type        = string
  default     = ""
}

variable "monitoring_role_name" {
  description = "Name of the IAM role which will be created when create_monitoring_role is enabled."
  type        = string
  default     = "rds-monitoring-role"
}

variable "create_monitoring_role" {
  description = "Create IAM role with a defined name that permits RDS to send enhanced monitoring metrics to CloudWatch Logs."
    type        = bool
    default     = false
  }
  
  variable "timezone" {
    description = "(Optional) Time zone of the DB instance. timezone is currently only supported by Microsoft SQL Server. The timezone can only be set on creation. See MSSQL User Guide for more information."
    type        = string
    default     = ""
  }
  
  variable "character_set_name" {
    description = "(Optional) The character set name to use for DB encoding in Oracle instances. This can't be changed. See Oracle Character Sets Supported in Amazon RDS for more information"
    type        = string
    default     = ""
  }
  
  variable "enabled_cloudwatch_logs_exports" {
    description = "List of log types to enable for exporting to CloudWatch logs. If omitted, no logs will be exported. Valid values (depending on engine): alert, audit, error, general, listener, slowquery, trace, postgresql (PostgreSQL), upgrade (PostgreSQL)."
    type        = list(string)
    default     = []
  }
  
  variable "timeouts" {
    description = "(Optional) Updated Terraform resource management timeouts. Applies to `aws_db_instance` in particular to permit resource management times"
    type        = map(string)
    default = {
      create = "15m"
      update = "40m"
      delete = "20m"
    }
  }
  
  variable "deletion_protection" {
    description = "The database can't be deleted when this value is set to true."
    type        = bool
    default     = false
  }
  
  variable "db_tags" {
    description = "A mapping of tags to assign to the resource"
    type        = map(string)
    default     = {}
  }
  
  variable "db_instance_class" {
    description = "The size of the database instance."
    type        = string
    default     = "db.t2.medium"
  }
  
  variable "db_storage_capacity" {
    description = "Database storage capacity"
    type        = number
    default     = 20
  }
  
  
  variable "db_snapshot" {
    description = "A database snapshot to use."
    type        = string
    default     = ""
  }
  
  variable "db_kms_key_id" {
    description = "KMS key for database encryption"
    type        = string
    default     = ""
  }
  
  variable "db_user_name" {
    description = "Database user name"
    type        = string
    default     = "root"
  }
  
  variable "db_password" {
    description = "The password for the RDS database instance (take note of this now)"
    type        = string
  
  }
  
  variable "db_multi_az" {
    description = "Placed DB in multi AZ"
    type        = bool
    default     = true
  }
  
  variable "db_subnet_group" {
    description = "DB subnets"
    type        = string
    default     = "vpc-privatedbsubnetgroup-1m9c945nbsbhk"
  }
  
  variable "db_storage_type" {
    description = "Storage type for DB instances"
    type        = string
    default     = "gp2"
  }
  
  variable "db_storage_iops" {
    description = "The IOPS for the database if using provisioned io1"
    type        = number
    default     = 1000
  }
  
  variable "db_name" {
    description = "Database name"
    type        = string
    default     = "test"
  }
  
  variable "assign_db_name" {
    description = "If true a name will be assigned to the database instance"
    type        = bool
    default     = true
  }
