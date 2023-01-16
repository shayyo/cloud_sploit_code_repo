resource "aws_instance" "nginx_server" {

  ami 		= "ami-038857f513f31e379"
  instance_type = "t2.micro"
  count		= 1
  key_name	= "test-cndr"
  associate_public_ip_address = true
  subnet_id	= aws_subnet.public.id
  vpc_security_group_ids	= [aws_security_group.wan-to-web-app_sg.id]

  tags = {
    Name = "NGINX_${count.index}"
  }
}

resource "aws_instance" "web_app_db_host" {

  ami           = "ami-038857f513f31e379"
  instance_type = "t2.micro"
  count         = 1
  key_name      = "test-cndr"
  associate_public_ip_address = false
  subnet_id     = aws_subnet.backend.id
  vpc_security_group_ids	= [aws_security_group.web-app_to_backend_sg.id]

  tags = {
    Name = "web_app_db_${count.index}"
  }
}
