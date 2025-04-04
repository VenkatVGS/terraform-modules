# Create New VPC
resource "aws_vpc" "myvpc" {
  cidr_block = var.cidr_vpc
}

# Create Pub Subnet
resource "aws_subnet" "pub-subnet" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.cidr_public_subnet
  availability_zone = "ap-south-1a"

  tags = {
    Name = "public-subnet1"
  }
}

# Create Prvt Subnet
resource "aws_subnet" "pvt-subnet" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.cidr_private_subnet
  availability_zone = "ap-south-1b"

  tags = {
    Name = "private-subnet"
  }
}
# Routing Table For Public
resource "aws_route_table" "pub-route" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "Public-route"
  }
  # depends_on = [aws_internet_gateway.igw]
}

# Crete Route Table Association For Public
resource "aws_route_table_association" "pub-route-ass" {
  subnet_id      = aws_subnet.pub-subnet.id
  route_table_id = aws_route_table.pub-route.id
}
# Routing Table For Private
resource "aws_route_table" "pvt-route" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    # vpc_peering_connection_id = aws_vpc_peering_connection.mypeer.id
    gateway_id = aws_nat_gateway.ngw.id
  }
  tags = {
    Name = "private-route"
  }
}
#Create Route Table Association For Private
resource "aws_route_table_association" "prt-route-ass" {
  subnet_id      = aws_subnet.pvt-subnet.id
  route_table_id = aws_route_table.pvt-route.id
}
# Pub Sg
resource "aws_security_group" "pub-sg" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    description      = "TLS from VPC"
    from_port        = var.sg_ssh
    to_port          = var.sg_ssh
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  ingress {
    description      = "TLS from VPC"
    from_port        = var.sg_http
    to_port          = var.sg_http
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Public-sg"
  }
}
# Pvt Sg
resource "aws_security_group" "pvt-sg" {
  name        = "private-sg"
  description = "Allow TLS inbound traffic for private sg"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    description      = "TLS from VPC"
    from_port        = var.sg_ssh
    to_port          = var.sg_ssh
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "prvt-sg"
  }
}

# Ec2 Pub
resource "aws_instance" "public-ec2" {
  ami    = var.ec2_ami_id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.pub-subnet.id
  key_name   = var.private_key
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.pub-sg.id]
  tags = {
    Name = "pub-vgs"
  }
}

# EC2 Prvt
resource "aws_instance" "private-ec2" {
  ami    = var.ec2_ami_id
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.pvt-subnet.id
  key_name   = var.private_key
  vpc_security_group_ids = [aws_security_group.pvt-sg.id]
  tags = {
    Name = "prvt-vgs"
  }
}

# Internet Gate Way
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "myigw"
  }
}
# EIP                                # Must Read Before Delete This
resource "aws_eip" "myeip" {
  vpc   =  true
}
# Nat Gate Way
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.myeip.id
  subnet_id     = aws_subnet.pub-subnet.id
  
  tags = {
    Name = "natgw"
  }
}
