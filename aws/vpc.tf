resource "aws_vpc" "my_web_app" {
  cidr_block  = "172.32.0.0/23"
  enable_dns_hostnames  = true

  tags = {
    Name  = "Web-app-VPC"
  }
}

resource "aws_subnet" "backend" {
  vpc_id  = aws_vpc.my_web_app.id
  cidr_block  = "172.32.0.0/24"
  availability_zone = "ap-northeast-3a"

  tags  = {
    Name  = "backend-subnet"
  }
}

resource "aws_subnet" "public" {
  vpc_id  = aws_vpc.my_web_app.id
  cidr_block  = "172.32.1.0/24"
  availability_zone = "ap-northeast-3a"

  tags  = {
    Name  = "Internet-subnet"
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id  = aws_vpc.my_web_app.id

  tags  = {
    Name  = "web-app-internet-gateway"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id  = aws_vpc.my_web_app.id

  route {
    cidr_block  = "0.0.0.0/0"
    gateway_id  = aws_internet_gateway.my_igw.id
  }

  tags  = {
  Name  = "web-app-rt"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id  = aws_vpc.my_web_app.id

  route {
    cidr_block  = "0.0.0.0/0"
    gateway_id  = aws_nat_gateway.backend_nat.id
  }

  tags  = {
  Name  = "web-app-backend-rt"
  }
}

resource "aws_route_table_association" "public_rt_association" {
  subnet_id = aws_subnet.public.id
  route_table_id  = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_rt_association" {
  subnet_id = aws_subnet.backend.id
  route_table_id  = aws_route_table.private_rt.id
}

resource "aws_eip" "elastic_ip_for_backend_nat" {
  vpc = true
  #private_ip  = ""
  tags  = {
  Name  = "elastic_ip_for_backend_nat"
  }
}

resource "aws_nat_gateway" "backend_nat" {
  allocation_id = aws_eip.elastic_ip_for_backend_nat.id
  subnet_id = aws_subnet.public.id
  private_ip  = "172.32.1.254"

  tags  = {
    Name  = "NAT gateway for backend services"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on  = [aws_internet_gateway.my_igw]
}%resource "aws_vpc" "my_web_app" {
  cidr_block  = "172.32.0.0/23"
  enable_dns_hostnames  = true

  tags = {
    Name  = "Web-app-VPC"
  }
}

resource "aws_subnet" "backend" {
  vpc_id  = aws_vpc.my_web_app.id
  cidr_block  = "172.32.0.0/24"
  availability_zone = "ap-northeast-3a"

  tags  = {
    Name  = "backend-subnet"
  }
}

resource "aws_subnet" "public" {
  vpc_id  = aws_vpc.my_web_app.id
  cidr_block  = "172.32.1.0/24"
  availability_zone = "ap-northeast-3a"

  tags  = {
    Name  = "Internet-subnet"
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id  = aws_vpc.my_web_app.id

  tags  = {
    Name  = "web-app-internet-gateway"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id  = aws_vpc.my_web_app.id

  route {
    cidr_block  = "0.0.0.0/0"
    gateway_id  = aws_internet_gateway.my_igw.id
  }

  tags  = {
  Name  = "web-app-rt"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id  = aws_vpc.my_web_app.id

  route {
    cidr_block  = "0.0.0.0/0"
    gateway_id  = aws_nat_gateway.backend_nat.id
  }

  tags  = {
  Name  = "web-app-backend-rt"
  }
}

resource "aws_route_table_association" "public_rt_association" {
  subnet_id = aws_subnet.public.id
  route_table_id  = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_rt_association" {
  subnet_id = aws_subnet.backend.id
  route_table_id  = aws_route_table.private_rt.id
}

resource "aws_eip" "elastic_ip_for_backend_nat" {
  vpc = true
  #private_ip  = ""
  tags  = {
  Name  = "elastic_ip_for_backend_nat"
  }
}

resource "aws_nat_gateway" "backend_nat" {
  allocation_id = aws_eip.elastic_ip_for_backend_nat.id
  subnet_id = aws_subnet.public.id
  private_ip  = "172.32.1.254"

  tags  = {
    Name  = "NAT gateway for backend services"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on  = [aws_internet_gateway.my_igw]
}
