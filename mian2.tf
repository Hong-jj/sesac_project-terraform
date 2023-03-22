# Create VPC
resource "aws_vpc" "tokyo_vpc" {
  cidr_block = "10.1.0.0/16"
  
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "Tokyo-VPC"
  }
}

# Create Public Subnet
resource "aws_subnet" "Tokyo-Public-1" {
  vpc_id = aws_vpc.tokyo_vpc.id
  cidr_block = "10.1.1.0/24"
  availability_zone = "${var.aws_region}a"
  
  tags = {
    Name = "Tokyo-Public-1a"
  }
}

resource "aws_subnet" "Tokyo-Public-2" {
  vpc_id = aws_vpc.tokyo_vpc.id
  cidr_block = "10.1.11.0/24"
  availability_zone = "${var.aws_region}c"
  
  tags = {
    Name = "Tokyo-Public-1c"
  }
}

# Create Private Subnet
resource "aws_subnet" "Tokyo-Private-1" {
  vpc_id = aws_vpc.tokyo_vpc.id
  cidr_block = "10.1.2.0/24"
  availability_zone = "${var.aws_region}a"
  
  tags = {
    Name = "Tokyo-Private-1a"
  }
}

resource "aws_subnet" "Tokyo-Private-2" {
  vpc_id = aws_vpc.tokyo_vpc.id
  cidr_block = "10.1.12.0/24"
  availability_zone = "${var.aws_region}c"
  
  tags = {
    Name = "Tokyo-Private-1c"
  }
}

resource "aws_subnet" "Tokyo-Private-3" {
  vpc_id = aws_vpc.tokyo_vpc.id
  cidr_block = "10.1.3.0/24"
  availability_zone = "${var.aws_region}a"
  
  tags = {
    Name = "Tokyo-Private-2a"
  }
}

resource "aws_subnet" "Tokyo-Private-4" {
  vpc_id = aws_vpc.tokyo_vpc.id
  cidr_block = "10.1.13.0/24"
  availability_zone = "${var.aws_region}c"
  
  tags = {
    Name = "Tokyo-Private-2c"
  }
}


# Create IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.tokyo_vpc.id
  
  tags = {
    Name = "Tokyo-igw"
  }
}

# Create Public Route Table 
resource "aws_route_table" "Tokyo_RT-1" {
  vpc_id = aws_vpc.tokyo_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "Tokyo RT1"
  }
}

# Public Subnet Assocation to Public Route Talbe
resource "aws_route_table_association" "public_rta-01"{
  subnet_id = aws_subnet.Tokyo-Public-1.id
  route_table_id = aws_route_table.Tokyo_RT-1.id
}

resource "aws_route_table_association" "public_rta-02" {
  subnet_id = aws_subnet.Tokyo-Public-2.id
  route_table_id = aws_route_table.Tokyo_RT-1.id
}

# Create NAT-Gateway
resource "aws_nat_gateway" "ngw-01" {
  allocation_id = aws_eip.eip-01.id
  subnet_id = aws_subnet.Tokyo-Public-1.id

  tags = {
    Name = "Tokyo-ngw-a"
  }
}

resource "aws_nat_gateway" "ngw-02" {
  allocation_id = aws_eip.eip-02.id
  subnet_id = aws_subnet.Tokyo-Public-2.id

  tags = {
    Name = "Tokyo-ngw-b"
  }
}

# NAT Gateway가 사용할 EIP(Elastic IP) 생성
resource "aws_eip" "eip-01" {
  vpc = true
  
  tags = {
    Name = "NGW-EIP-01"
  }
}

resource "aws_eip" "eip-02" {
  vpc = true
  
  tags = {
    Name = "NGW-EIP-02"
  }
}

# Creat Private Route Talbe
resource "aws_route_table" "Tokyo_RT-2" {
  vpc_id = aws_vpc.tokyo_vpc.id
  route{
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw-01.id
  }
  tags = {
    Name = "Tokyo RT-2"
  }
}

resource "aws_route_table" "Tokyo_RT-3" {
  vpc_id = aws_vpc.tokyo_vpc.id
  route{
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw-02.id
  }
  tags = {
    Name = "Tokyo RT-3"
  }
}

# 프라이빗 서브넷과 라우트 테이블 연결
resource "aws_route_table_association" "private_rta-01" {
  subnet_id = aws_subnet.Tokyo-Private-1.id
  route_table_id = aws_route_table.Tokyo_RT-2.id
}
resource "aws_route_table_association" "private_rta-02" {
  subnet_id = aws_subnet.Tokyo-Private-3.id
  route_table_id = aws_route_table.Tokyo_RT-2.id
}
resource "aws_route_table_association" "private_rta-03" {
  subnet_id = aws_subnet.Tokyo-Private-2.id
  route_table_id = aws_route_table.Tokyo_RT-3.id
}
resource "aws_route_table_association" "private_rta-04" {
  subnet_id = aws_subnet.Tokyo-Private-4.id
  route_table_id = aws_route_table.Tokyo_RT-3.id
}

# Web Instance에서 사용할 Security_Gorup생성
resource "aws_security_group" "web_security_group" {
  vpc_id      = aws_vpc.tokyo_vpc.id
  name_prefix = "web-security-group"

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # ingress{
  #   description = "Allow Django Port"
  #   from_port = 8000
  #   to_port = 8000
  #   protocol = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }
  ingress{
    from_port = 443
    to_port = 443
    protocol ="tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    # Private Subnet에서 외부와 통신할 수 있도록 CIDR 블록을 지정합니다.
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags ={
    Name = "Allow SSH,HTTP,Django"
  }
}

# DB Security_Group 생성
resource "aws_security_group" "db_security_group" {
  vpc_id      = aws_vpc.tokyo_vpc.id
  name_prefix = "db-security-group"

  ingress {
    description = "Allow DB Port"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    # Private Subnet에서 외부와 통신할 수 있도록 CIDR 블록을 지정합니다.
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags ={
    Name = "Allow DB,SSH"
  }
}

# HTTPS 포트가 열린 보안 그룹 생성
resource "aws_security_group" "https_sg" {
  name_prefix = "My HTTPS SG"
  vpc_id      = aws_vpc.tokyo_vpc.id

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags ={
    Name = "Allow HTTPS"
  }
  
}

# .ssm, .ssmmessages, .ec2messages,.ec2 엔드포인트 생성 (Quick Start로 구성시 ec2엔드포인트 생성 필요X)
resource "aws_vpc_endpoint" "ssm_endpoint" {
  vpc_id = aws_vpc.tokyo_vpc.id
  service_name = "com.amazonaws.ap-northeast-1.ssm"
  vpc_endpoint_type = "Interface"   
  subnet_ids = [aws_subnet.Tokyo-Private-1.id]
  security_group_ids = [aws_security_group.https_sg.id]
  private_dns_enabled = true  # private DNS 이름 활성화

  tags = {
    Name = "ssm_endpoint"
  }
  
}

resource "aws_vpc_endpoint" "ssmmessages_endpoint" {
  vpc_id = aws_vpc.tokyo_vpc.id
  service_name = "com.amazonaws.ap-northeast-1.ssmmessages"
  vpc_endpoint_type = "Interface"
  subnet_ids = [aws_subnet.Tokyo-Private-1.id]
  security_group_ids = [aws_security_group.https_sg.id]
  private_dns_enabled = true  # private DNS 이름 활성화

  tags = {
    Name = "ssmmessages_endpoint"
  }
  
}

resource "aws_vpc_endpoint" "ec2messages_endpoint" {
  vpc_id = aws_vpc.tokyo_vpc.id
  service_name = "com.amazonaws.ap-northeast-1.ec2messages"
  vpc_endpoint_type = "Interface"
  subnet_ids = [aws_subnet.Tokyo-Private-1.id]
  security_group_ids = [aws_security_group.https_sg.id]
  private_dns_enabled = true  # private DNS 이름 활성화

  tags = {
    Name = "ec2message_endpoint"
  }
  
}

resource "aws_vpc_endpoint" "ec2_endpoint" {
  vpc_id = aws_vpc.tokyo_vpc.id
  service_name = "com.amazonaws.ap-northeast-1.ec2"
  vpc_endpoint_type = "Interface"
  subnet_ids = [aws_subnet.Tokyo-Private-1.id]
  security_group_ids = [aws_security_group.https_sg.id]
  private_dns_enabled = true  # private DNS 이름 활성화

  tags = {
    Name = "ec2_endpoint"
  }
  
}


#다른 Region의 AMI Copy
resource "aws_ami_copy" "Django_ami" {
  name              = "Django-AMI"
  description       = "A copy of Django web ami"
  source_ami_id     = "ami-00ef3bbb28d7be777"
  source_ami_region = "ap-northeast-2"

  
  tags = {
    Name = "Django_ami"
  }
}


# 프라이빗 서브넷에 프라이빗 IP만 할당된 프라이빗 EC2 인스턴스 생성
resource "aws_instance" "private_ec2_01" {
  ami = aws_ami_copy.Django_ami.id
  instance_type = "t3.micro"
  associate_public_ip_address = false  # 퍼블릭 IP 할당 안함
  subnet_id = aws_subnet.Tokyo-Private-1.id
  vpc_security_group_ids = [aws_security_group.web_security_group.id]
  private_dns_name_options {
    enable_resource_name_dns_a_record = true
  }
  # IAM 인스턴스 프로필 연결
  iam_instance_profile = "EC2-SSM"
  
  tags = {
    Name = "Django-01"
  }
}

resource "aws_instance" "private_ec2_02" {
  ami = aws_ami_copy.Django_ami.id
  instance_type = "t3.micro"
  associate_public_ip_address = false  # 퍼블릭 IP 할당 안함
  subnet_id = aws_subnet.Tokyo-Private-2.id
  vpc_security_group_ids = [aws_security_group.web_security_group.id]
  private_dns_name_options {
    enable_resource_name_dns_a_record = true
  }
  # IAM 인스턴스 프로필 연결
  iam_instance_profile = "EC2-SSM"
  
  tags = {
    Name = "Django-02"
  }
}


# Create Launch Template
resource "aws_launch_template" "Django_launch_template" {
  name_prefix   = "Django-Tem"
  description = "Django launch template"
  image_id = aws_ami_copy.Django_ami.id
  instance_type = var.instance_type
  
  
# 위에서 생성한 Security Group ID를 지정합니다.
vpc_security_group_ids = ["${aws_security_group.web_security_group.id}"]

#   # IAM 인스턴스 프로필 연결
   iam_instance_profile {
     name = "EC2-SSM"
   }
  
   tag_specifications {
     resource_type = "instance"

   tags = {
       Name = "Django-instance"
     }
  }
}
 
# Auto Scaling Group을 생성하는 코드를 작성합니다.
resource "aws_autoscaling_group" "Django_autoscaling_group" {
  name                = "Django-autoscaling-group"
  vpc_zone_identifier = ["${aws_subnet.Tokyo-Private-1.id}", "${aws_subnet.Tokyo-Private-2.id}"]

  launch_template {
    id      = aws_launch_template.Django_launch_template.id
    version = "$Latest"
  }
  desired_capacity          = 1
  min_size                  = 1
  max_size                  = 3
  health_check_grace_period = 300
  health_check_type         = "ELB"

  # Auto Scaling Group에 Name 태그를 추가합니다.
  tag {
    key                 = "Name"
    value               = "Django-instance"
    propagate_at_launch = true
  }
  lifecycle {
    ignore_changes = [load_balancers, target_group_arns]
  }
}

#Auto Scaling Group에 LB를 연결한다.
resource "aws_autoscaling_attachment" "web_asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.Django_autoscaling_group.id
  lb_target_group_arn    = aws_lb_target_group.web_target_group.arn
}

# Application Load Balancer를 생성하는 코드를 작성합니다.
resource "aws_lb" "main" {
  name               = "web-lb"
  internal           = false
  load_balancer_type = "application"

  # Load Balancer와 Public Subnet을 연결합니다.
  subnets         = ["${aws_subnet.Tokyo-Public-1.id}", "${aws_subnet.Tokyo-Public-2.id}"]
  security_groups = ["${aws_security_group.lb_security_group.id}"]
  

  tags = {
    Name = "Django_web-ALB"
  }
}

# Target Group을 생성하는 코드를 작성합니다.
resource "aws_lb_target_group" "web_target_group" {
  name_prefix = "web-tg"

  port     = 80
  protocol = "HTTP"

#위에서 생성한 VPC ID를 지정합니다.
  vpc_id = aws_vpc.tokyo_vpc.id
  target_type = "instance"

  health_check {
    path     = "/health-check"
    #interval = 12
    #timeout  = 4
  }

  #Target Group이 생성되기 전에 아래 리소스 생성을 기다림
  depends_on = [
    aws_autoscaling_group.Django_autoscaling_group
  ]

  lifecycle {
    create_before_destroy = true
  }
}

# Target Group에 instance 대상 등록
resource "aws_lb_target_group_attachment" "attach_ec2-01"{
  target_group_arn = aws_lb_target_group.web_target_group.arn
  target_id   = aws_instance.private_ec2_01.id
  port = 80
}
resource "aws_lb_target_group_attachment" "attach_ec2-02"{
  target_group_arn = aws_lb_target_group.web_target_group.arn
  target_id   = aws_instance.private_ec2_02.id
  port = 80
}


# ALB에서 HTTP -> HTTPS 리다이렉트
resource "aws_lb_listener" "web_listener_80" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action{
    type      = "redirect"
  

    redirect{
      port  = "443"
      protocol  = "HTTPS"
      status_code = "HTTP_301"
    }
  }

}

# Listener를 생성하는 코드를 작성합니다.
resource"aws_lb_listener" "web_listener_443"{
  load_balancer_arn = aws_lb.main.arn
  port          = "443"
  protocol      = "HTTPS"
  ssl_policy    = "ELBSecurityPolicy-2016-08"
  certificate_arn = "arn:aws:acm:ap-northeast-1:417574981094:certificate/135fc005-95e9-4f87-a18e-ecb05bc4f624"

    # 위에서 생성한 Target Group을 지정합니다.
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_target_group.arn
  }  
}

# LB용 Security Group을 생성하는 코드를 작성합니다.
resource "aws_security_group" "lb_security_group" {
  vpc_id      = aws_vpc.tokyo_vpc.id
  name_prefix = "lb-security-group"

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    # Public Subnet에서 Application Load Balancer에 접속할 수 있도록 CIDR 블록을 지정합니다.
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress{
    from_port = 443
    to_port = 443
    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    # Private Subnet에서 외부와 통신할 수 있도록 CIDR 블록을 지정합니다.
    cidr_blocks = ["0.0.0.0/0"]
  }
}
