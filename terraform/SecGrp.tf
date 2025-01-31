resource "aws_security_group" "yolo-sg" {
  name        = "yolo-sg"
  description = "yolo-sg"


  tags = {
    Name = "yolo-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "sshformmyip" {
  security_group_id = aws_security_group.yolo-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allowhttp" {
  security_group_id = aws_security_group.yolo-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}
resource "aws_vpc_security_group_ingress_rule" "yolojenkinsport" {
  security_group_id = aws_security_group.yolo-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 8080
  ip_protocol       = "tcp"
  to_port           = 8080
}
resource "aws_vpc_security_group_ingress_rule" "yolodockerportp" {
  security_group_id = aws_security_group.yolo-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 8000
  ip_protocol       = "tcp"
  to_port           = 8000
}

resource "aws_vpc_security_group_egress_rule" "allowalloutbound_ipv4" {
  security_group_id = aws_security_group.yolo-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" 
}

resource "aws_vpc_security_group_egress_rule" "allowalloutbound_ipv6" {
  security_group_id = aws_security_group.yolo-sg.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" 
}





