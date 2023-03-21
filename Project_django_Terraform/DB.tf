# 현재 프로젝트(backup region)는 DB는 Terraform으로 생성하지 않음

# # Aurora DB 클러스터와 연결된 DB 서브넷 그룹을 생성합니다.
# resource "aws_db_subnet_group" "aurora_db_subnet_group" {
#   name       = "aurora-db-subnet-group"
#   subnet_ids = [ aws_subnet.private_subnet_01.id ,aws_subnet.private_subnet_02.id ]
# }

# # Aurora DB 클러스터를 생성합니다.
# resource "aws_rds_cluster" "aurora_cluster" {
#   cluster_identifier      = "aurora-cluster"
#   engine                  = "aurora-mysql"
#   engine_version          = "5.7.mysql_aurora.2.11.1"
#   engine_mode             = "provisioned"
#   database_name           = "BTS_web"
#   master_username         = var.master_username
#   master_password         = var.master_password
#   backup_retention_period = 7
#   skip_final_snapshot     = true
#   deletion_protection    = "false"
  

#   # Aurora DB 클러스터와 연결된 보안 그룹을 지정합니다.
#   vpc_security_group_ids  = [aws_security_group.db_security_group.id]

#   # Aurora DB 클러스터와 연결된 DB 서브넷 그룹을 지정합니다.
#   db_subnet_group_name    = aws_db_subnet_group.aurora_db_subnet_group.name

#   #AZ(가용영역) 지정
#   availability_zones = ["${var.aws_region}a","${var.aws_region}b"]

#   #클러스터 구성 (# aws_rds_cluster_instance 의 identifier와 맞춰야 함)
#   cluster_members = ["aurora-instance-1" ,"aurora-instance-2"]

# }
# # Aurora DB 인스턴스를 생성합니다.
# resource "aws_rds_cluster_instance" "aurora_instance_1" {
#   cluster_identifier = aws_rds_cluster.aurora_cluster.id
#   instance_class     = var.db_instance_type
#   engine             = aws_rds_cluster.aurora_cluster.engine
#   engine_version     = aws_rds_cluster.aurora_cluster.engine_version
#   identifier         = "aurora-instance-1"

#   # Aurora DB 인스턴스에 태그를 지정합니다.
#   tags = {
#     Name = "Aurora DB Instance-01"
#   }
# }

# #Aurora DB 인스턴스를 생성합니다.
# resource "aws_rds_cluster_instance" "aurora_instance_2" {
#   cluster_identifier = aws_rds_cluster.aurora_cluster.id
#   instance_class     = var.db_instance_type
#   engine             = aws_rds_cluster.aurora_cluster.engine
#   engine_version     = aws_rds_cluster.aurora_cluster.engine_version
#   identifier         = "aurora-instance-2"

#   # Aurora DB 인스턴스에 태그를 지정합니다.
#   tags = {
#     Name = "Aurora DB Instance-02"
#   }
# }

# DB 서브넷 그룹 생성
resource "aws_db_subnet_group" "tokyo_subnetgorup"{
    name    = "tokyo-subnet-gorup"
    subnet_ids  = [aws_subnet.Tokyo-Private-3.id ,aws_subnet.Tokyo-Private-4.id]

    tags ={
        Name = "Use for Aurora DB region replica"
    }
}