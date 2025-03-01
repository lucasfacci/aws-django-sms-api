resource "aws_security_group" "machine_sg" {
  name        = "${var.project_name}-sg"
  description = "Security group to secure the API."

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-machine-sg"
    }
  )
}

resource "aws_vpc_security_group_ingress_rule" "allow_inbound_http_access" {
  security_group_id = aws_security_group.machine_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_inbound_https_access" {
  security_group_id = aws_security_group.machine_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_outbound_http_access" {
  security_group_id = aws_security_group.machine_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_outbound_https_access" {
  security_group_id = aws_security_group.machine_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443
}
