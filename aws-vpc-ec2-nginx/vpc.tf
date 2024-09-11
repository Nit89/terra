resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my_vpc"
  }
}

#private subnet 

resource "aws_subnet" "private-subnet" {
  
  cidr_block = "10.0.3.0/24"
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "private-subnet"
  }
}

#public subnet

resource "aws_subnet" "public-subnet" {
  
  cidr_block = "10.0.2.0/24"
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "public-subnet"
  }
}


# internet gateway 

resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags ={
    Name = "my-igw"
  } 
}

#Routing table 

resource "aws_route_table" "my_rt" {
     vpc_id = aws_vpc.my_vpc.id
     route {
      cidr_block ="0.0.0.0/0"
      gateway_id = aws_internet_gateway.my-igw.id
     }
}

resource "aws_route_table_association" "public-sub" {
  route_table_id = aws_route_table.my_rt.id
  subnet_id =   aws_subnet.public-subnet.id
}



