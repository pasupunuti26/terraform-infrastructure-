# EC2 Web Server

resource "aws_instance" "com_web_server" {

  ami           = "ami-xxxxxxxxxxxxxxxxx"
  instance_type = "t2.micro"

  subnet_id = aws_subnet.com_web_sn.id

  key_name = "eks-key.pem"

  vpc_security_group_ids = [
    aws_security_group.web_sg.id
  ]

  user_data = file("setup.sh")

  tags = {
    Name = "com-web-server"
  }
}