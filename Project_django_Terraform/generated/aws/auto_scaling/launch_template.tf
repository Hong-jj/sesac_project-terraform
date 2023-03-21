resource "aws_launch_template" "tfer--Tem-ver0-002E-1" {
  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      delete_on_termination = "true"
      encrypted             = "false"
      iops                  = "0"
      throughput            = "0"
      volume_size           = "10"
      volume_type           = "gp2"
    }
  }

  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  credit_specification {
    cpu_credits = "standard"
  }

  default_version         = "1"
  description             = "Django_WEB-Tem"
  disable_api_stop        = "false"
  disable_api_termination = "false"
  ebs_optimized           = "false"

  iam_instance_profile {
    arn = "arn:aws:iam::687365294585:instance-profile/EC2-SSM-Role"
  }

  image_id      = "ami-0735c191cf914754d"
  instance_type = "t2.micro"

  maintenance_options {
    auto_recovery = "default"
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = "1"
    http_tokens                 = "optional"
    instance_metadata_tags      = "enabled"
  }

  monitoring {
    enabled = "true"
  }

  name = "Tem-ver0.1"

  network_interfaces {
    associate_public_ip_address = "false"
    delete_on_termination       = "true"
    device_index                = "0"
    ipv4_address_count          = "0"
    ipv4_prefix_count           = "0"
    ipv6_address_count          = "0"
    ipv6_prefix_count           = "0"
    network_card_index          = "0"
    security_groups             = ["sg-0612b9d806afef954", "sg-09b02cf6cbdcb6a08", "sg-0be4f324f97b9d75b"]
  }

  placement {
    availability_zone = "us-west-2a"
    partition_number  = "0"
    tenancy           = "default"
  }

  private_dns_name_options {
    enable_resource_name_dns_a_record    = "true"
    enable_resource_name_dns_aaaa_record = "false"
    hostname_type                        = "ip-name"
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "Django_Web-Tem"
    }
  }
}

resource "aws_launch_template" "tfer--Test-Tem" {
  default_version         = "1"
  description             = "Test-Template"
  disable_api_stop        = "false"
  disable_api_termination = "false"

  iam_instance_profile {
    arn = "arn:aws:iam::687365294585:instance-profile/EC2-SSM-Role"
  }

  image_id      = "ami-0f1a5f5ada0e7da53"
  instance_type = "t3.micro"

  monitoring {
    enabled = "true"
  }

  name = "Test-Tem"

  network_interfaces {
    device_index       = "0"
    ipv4_address_count = "0"
    ipv4_prefix_count  = "0"
    ipv6_address_count = "0"
    ipv6_prefix_count  = "0"
    network_card_index = "0"
  }

  private_dns_name_options {
    enable_resource_name_dns_a_record    = "true"
    enable_resource_name_dns_aaaa_record = "false"
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "Test-ATG"
    }
  }

  user_data = "IyEvYmluL2Jhc2ggLXhlCnN1ZG8geXVtIHVwZGF0ZSAteQpzdWRvIHl1bSBpbnN0YWxsIC15IGh0dHBkCnN1ZG8gc3lzdGVtY3RsIHN0YXJ0IGh0dHBkCnN1ZG8gc3lzdGVtY3RsIGVuYWJsZSBodHRwZApzdWRvIGVjaG8gIkhlbGxvIFdvcmxkIiA+IC92YXIvd3d3L2h0bWwvaW5kZXguaHRtbA=="
}
