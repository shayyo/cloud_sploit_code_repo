resource "aws_security_group" "wan-to-web-app_sg" {
  name        = "wan-to-web-app_sg"
  description = "allow traffic from wan to web app "
  vpc_id      = aws_vpc.my_web_app.id

  ingress {
    description      = "ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "http"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "web-app_to_backend_sg" {
  name        = "web-app_to_backend_sg"
  description = "allow traffic from web app to backend"
  vpc_id      = aws_vpc.my_web_app.id

  ingress {
    description      = "ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [aws_subnet.public.cidr_block]
  }

  ingress {
    description      = "redis"
    from_port        = 6379
    to_port          = 6379
    protocol         = "tcp"
    cidr_blocks      = [aws_subnet.public.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}
