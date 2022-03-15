# -----------------
# RESOURCE
# -----------------
resource "aws_vpc" "main" {
  cidr_block = var.vpc.cidr_block
  tags       = var.vpc.tags
}

resource "aws_subnet" "main" {
  for_each                = var.vpc.subnets
  vpc_id                  = aws_vpc.main.id
  availability_zone       = each.value.availability_zone
  cidr_block              = each.value.cidr_block
  map_public_ip_on_launch = true

  tags = {
    Name = "${each.key}"
  }
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "RT-${var.vpc.tags["Name"]}"
  }
}

resource "aws_route" "route" {
  route_table_id         = aws_route_table.main.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

resource "aws_route_table_association" "main" {
  for_each       = aws_subnet.main
  subnet_id      = each.value.id
  route_table_id = aws_route_table.main.id
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "IGW-${var.vpc.tags["Name"]}"
  }
}

resource "aws_security_group" "allow_traffic" {
  name        = "PingSSH"
  description = "Allow Ping and SSH traffic"
  vpc_id      = aws_vpc.main.id

  ingress = [
    {
      description      = "SSH into VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
    {
      description      = "Ping VPC"
      from_port        = -1
      to_port          = -1
      protocol         = "icmp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress = [
    {
      description      = "Allow all outbound"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  tags = {
    Name = "SG-${var.vpc.tags["Name"]}"
  }
}