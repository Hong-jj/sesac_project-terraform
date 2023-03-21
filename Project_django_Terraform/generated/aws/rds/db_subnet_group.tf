resource "aws_db_subnet_group" "tfer--rds-ec2-db-subnet-group-1" {
  description = "Created from the RDS Management Console"
  name        = "rds-ec2-db-subnet-group-1"
  subnet_ids  = ["subnet-03567f62b7845d59b", "subnet-05b652f03eca0740e", "subnet-0a8d488f9d83f7401", "subnet-0cb208eb4feb327d0"]
}
