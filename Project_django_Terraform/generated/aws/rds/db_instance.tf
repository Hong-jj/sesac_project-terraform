resource "aws_db_instance" "tfer--test-db-01-instance-1" {
  allocated_storage                     = "1"
  auto_minor_version_upgrade            = "true"
  availability_zone                     = "us-west-2c"
  backup_retention_period               = "1"
  backup_window                         = "10:30-11:00"
  ca_cert_identifier                    = "rds-ca-2019"
  copy_tags_to_snapshot                 = "false"
  customer_owned_ip_enabled             = "false"
  db_name                               = "Test_Web01_DB"
  db_subnet_group_name                  = "${aws_db_subnet_group.tfer--rds-ec2-db-subnet-group-1.name}"
  deletion_protection                   = "false"
  engine                                = "aurora-mysql"
  engine_version                        = "5.7.mysql_aurora.2.11.1"
  iam_database_authentication_enabled   = "false"
  identifier                            = "test-db-01-instance-1"
  instance_class                        = "db.t3.small"
  iops                                  = "0"
  license_model                         = "general-public-license"
  maintenance_window                    = "mon:08:26-mon:08:56"
  max_allocated_storage                 = "0"
  monitoring_interval                   = "60"
  monitoring_role_arn                   = "arn:aws:iam::687365294585:role/rds-monitoring-role"
  multi_az                              = "false"
  name                                  = "Test_Web01_DB"
  network_type                          = "IPV4"
  option_group_name                     = "default:aurora-mysql-5-7"
  parameter_group_name                  = "default.aurora-mysql5.7"
  performance_insights_enabled          = "false"
  performance_insights_retention_period = "0"
  port                                  = "3306"
  publicly_accessible                   = "false"
  storage_encrypted                     = "false"
  storage_throughput                    = "0"
  storage_type                          = "aurora"
  username                              = "admin"
  vpc_security_group_ids                = ["sg-0649ffccc848a9c1b"]
}

resource "aws_db_instance" "tfer--test-db-01-instance-1-us-west-2a" {
  allocated_storage                     = "1"
  auto_minor_version_upgrade            = "true"
  availability_zone                     = "us-west-2a"
  backup_retention_period               = "1"
  backup_window                         = "10:30-11:00"
  ca_cert_identifier                    = "rds-ca-2019"
  copy_tags_to_snapshot                 = "false"
  customer_owned_ip_enabled             = "false"
  db_name                               = "Test_Web01_DB"
  db_subnet_group_name                  = "${aws_db_subnet_group.tfer--rds-ec2-db-subnet-group-1.name}"
  deletion_protection                   = "false"
  engine                                = "aurora-mysql"
  engine_version                        = "5.7.mysql_aurora.2.11.1"
  iam_database_authentication_enabled   = "false"
  identifier                            = "test-db-01-instance-1-us-west-2a"
  instance_class                        = "db.t3.small"
  iops                                  = "0"
  license_model                         = "general-public-license"
  maintenance_window                    = "mon:08:03-mon:08:33"
  max_allocated_storage                 = "0"
  monitoring_interval                   = "60"
  monitoring_role_arn                   = "arn:aws:iam::687365294585:role/rds-monitoring-role"
  multi_az                              = "false"
  name                                  = "Test_Web01_DB"
  network_type                          = "IPV4"
  option_group_name                     = "default:aurora-mysql-5-7"
  parameter_group_name                  = "default.aurora-mysql5.7"
  performance_insights_enabled          = "false"
  performance_insights_retention_period = "0"
  port                                  = "3306"
  publicly_accessible                   = "false"
  storage_encrypted                     = "false"
  storage_throughput                    = "0"
  storage_type                          = "aurora"
  username                              = "admin"
  vpc_security_group_ids                = ["sg-0649ffccc848a9c1b"]
}