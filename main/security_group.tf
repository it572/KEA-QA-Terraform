resource "aws_security_group" "qa_app" {
  name        = "${var.project_name}-sg"
  description = "QA app server - restrictive inbound/outbound"
  vpc_id      = aws_vpc.qa.id

  tags = {
    Name        = "${var.project_name}-sg"
    Environment = "QA"
  }
}

resource "aws_vpc_security_group_ingress_rule" "app_ports" {
  for_each = toset([for p in var.app_ports : tostring(p)])

  security_group_id =  aws_security_group.qa_app.id
  description = "App port ${each.value}"
  
  cidr_ipv4 = "0.0.0.0/0"
  from_port = each.value
  to_port = each.value
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "https" {
  security_group_id = aws_security_group.qa_app.id
  description = "HTTPS out - package installs, AWS APIs,  third-party SaaS APIs"
  
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 443
  to_port = 443
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "dns_udp" {
  security_group_id = aws_security_group.qa_app.id
  description = "DNS resolution (UDP)"

  cidr_ipv4 = "0.0.0.0/0"
  from_port = 53
  to_port = 53
  ip_protocol = "udp"
}

resource "aws_vpc_security_group_egress_rule" "dns_tcp" {
  security_group_id = aws_security_group.qa_app.id
  description = "DNS resolution (TCP, for larger responses)"

  cidr_ipv4 = "0.0.0.0/0"
  from_port = 53
  to_port = 53
  ip_protocol = "tcp"
}

