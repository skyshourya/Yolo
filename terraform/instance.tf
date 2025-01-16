resource "aws_instance" "web" {
  ami                    = data.aws_ami.amiID.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  availability_zone      = var.aws_zone
  vpc_security_group_ids = [aws_security_group.yolo-sg.id]

  
  tags = {
    Name    = "yolo-Instance"
    project = "yolo"
    
}
resource "aws_instance" "web" {
  ami                    = data.aws_ami.amiID.id
  instance_type          = t2.micro
  key_name               = jenag-key
  availability_zone      = var.aws_zone
  vpc_security_group_ids = [aws_security_group.yolo-jenag-sg]

  
  tags = {
    Name    = "jenkins-agent"
    project = "yolo"
    
}
