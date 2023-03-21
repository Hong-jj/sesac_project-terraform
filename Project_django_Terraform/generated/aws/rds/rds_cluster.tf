resource "aws_rds_cluster" "tfer--test-db-01" {
  allocated_storage                   = "1"
  availability_zones                  = ["us-west-2a", "us-west-2b", "us-west-2c"]
  backtrack_window                    = "0"
  backup_retention_period             = "1"
  cluster_identifier                  = "test-db-01"
  cluster_members                     = ["test-db-01-instance-1", "test-db-01-instance-1-us-west-2a"]
  copy_tags_to_snapshot               = "false"
  database_name                       = "Test_Web01_DB"
  db_cluster_parameter_group_name     = "default.aurora-mysql5.7"
  db_subnet_group_name                = "${aws_db_subnet_group.tfer--rds-ec2-db-subnet-group-1.name}"
  deletion_protection                 = "true"
  enable_http_endpoint                = "false"
  engine                              = "aurora-mysql"
  engine_mode                         = "provisioned"
  engine_version                      = "5.7.mysql_aurora.2.11.1"
  iam_database_authentication_enabled = "false"
  iops                                = "0"
  master_username                     = "admin"
  network_type                        = "IPV4"
  port                                = "3306"
  preferred_backup_window             = "10:30-11:00"
  preferred_maintenance_window        = "mon:12:00-mon:12:30"
  storage_encrypted                   = "false"
  vpc_security_group_ids              = ["sg-0649ffccc848a9c1b"]
}
