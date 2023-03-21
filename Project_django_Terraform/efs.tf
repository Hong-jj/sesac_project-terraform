# EFS_File_System 생성
resource "aws_efs_file_system" "ec2_efs"{
    creation_token  = "my-product"

    lifecycle_policy{
        transition_to_ia = "AFTER_30_DAYS"
    }

    tags = {
        Name = "EC2_efs"
    }
}

# Taget에 mount
resource "aws_efs_mount_target" "EC2_target_01"{
    file_system_id = aws_efs_file_system.ec2_efs.id
    subnet_id   = aws_subnet.Tokyo-Private-1.id
    security_groups =  [aws_security_group.web_efs_security_group.id]
    
}
resource "aws_efs_mount_target" "EC2_target_02"{
    file_system_id = aws_efs_file_system.ec2_efs.id
    subnet_id   = aws_subnet.Tokyo-Private-2.id
    security_groups =  [aws_security_group.web_efs_security_group.id]
    
}

# EFS용 Security Group을 생성하는 코드를 작성합니다.
resource "aws_security_group" "web_efs_security_group" {
  vpc_id      = aws_vpc.tokyo_vpc.id
  name_prefix = "web-efs-security-group"

  ingress {
    from_port = 2049
    to_port   = 2049
    protocol  = "tcp"

    # web_lb에서 오는 트래픽만 허용
    security_groups = [aws_security_group.web_security_group.id]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    # Private Subnet에서 외부와 통신할 수 있도록 CIDR 블록을 지정합니다.
    cidr_blocks = ["0.0.0.0/0"]
  }
}