resource "aws_vpc" "ecs-default" {
  assign_generated_ipv6_cidr_block = false
  cidr_block                       = "10.0.0.0/16"
  enable_classiclink               = false
  enable_classiclink_dns_support   = false
  enable_dns_hostnames             = true
  enable_dns_support               = true
  instance_tenancy                 = "default"
  tags = {
    "Description" = "Created for ECS cluster default"
    "Name"        = "ECS default - VPC"
  }
}

resource "aws_subnet" "ecs-default" {
  assign_ipv6_address_on_creation = false
  availability_zone               = var.aws-availability-zone
  cidr_block                      = "10.0.0.0/24"
  map_public_ip_on_launch         = false
  tags = {
    "Description" = "Created for ECS cluster default"
    "Name"        = "ECS default - Public Subnet 1"
  }
  vpc_id = aws_vpc.ecs-default.id

  timeouts {}
}

resource "aws_security_group" "ecs-default" {
  description = "ECS Allowed Ports"
  vpc_id      = aws_vpc.ecs-default.id

  ingress = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 25565
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 25565
    },
  ]

  egress = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
  ]

  tags = {
    "Description" = "Created for ECS cluster default"
    "Name"        = "ECS default - ECS SecurityGroup"
  }
}

resource "aws_security_group" "allow_nfs" {
  name        = "NFS"
  description = "NFS"
  vpc_id      = aws_vpc.ecs-default.id

  ingress = [
    {
      description      = ""
      cidr_blocks      = []
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      self             = false
      protocol         = "TCP"
      to_port          = "2049"
      from_port        = "2049"
      security_groups = [
        aws_security_group.ecs-default.id
      ]
    }
  ]

  egress = [
    {
      description      = ""
      cidr_blocks      = []
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      to_port          = "0"
      from_port        = "0"
      cidr_blocks = [
        "0.0.0.0/0"
      ]
      security_groups = []
      self            = false
    }
  ]

  tags = {
    Name = "minecraft-on-ecs"
  }
}
