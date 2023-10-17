provider "aws" {
  region = "ap-northeast-1"
}

//Create vpc resouce with cidr = "10.0.0.0/16"
resource "aws_vpc" "vpc"{
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true

    tags = {
        "Name"  = "terraform-vpc-custom"
    }
}
//Create NAT method to private network can change to global IP
resource "aws_eip" "nat"{
    
}

//Declare a locals 
locals{
    public = ["10.0.5.0/24","10.0.6.0/24"]
    private = ["10.0.7.0/24","10.0.8.0/24"]
    zone = ["ap-northeast-1a","ap-northeast-1c"]
}




//Create Private Subnet with private subnet private = ["10.0.7.0/24","10.0.8.0/24"]
resource "aws_subnet" "private_subnet"{
    count = length(local.private)
    vpc_id = aws_vpc.vpc.id
    cidr_block = local.private[count.index]

    availability_zone =  local.zone[count.index  % length(local.zone)]
    tags =  {
        "Name" = "private-subnet"
    }
}
//Create Public Subnet with public subnet public = ["10.0.5.0/24","10.0.6.0/24"]
resource "aws_subnet" "public_subnet"{
    count = length(local.public)
    vpc_id = aws_vpc.vpc.id
    cidr_block =  local.public[count.index]
    availability_zone =  local.zone[count.index % length(local.zone)]
    tags =  {
        "Name" = "public-subnet"
    }
}
//Create internet_gateway 
resource "aws_internet_gateway" "igw-custom"{
    vpc_id = aws_vpc.vpc.id
    tags = {
        "Name" = "ig-terraform"
    }
}
//Create route_table for ec2 can access to internet
resource "aws_route_table" "public"{
    vpc_id = aws_vpc.vpc.id

    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw-custom.id
    }
    tags = {
        "Name" = "rtb-terraform"
    }
}
//Associate Route_Table to public subnet
resource  "aws_route_table_association" "public_association"{
    for_each = {for k,v in aws_subnet.public_subnet : k => v}
    subnet_id =  each.value.id
    route_table_id = aws_route_table.public.id
}


/* resource "aws_nat_gateway" "public"{
    depends_on = [aws.aws_internet_gateway.igw-custom]
    allocation_id = ews_eip.nat.id
    subnet_id = aws_subnet.public_subnet[0].id
    tags = {
        Name = "Public Nat"
    }
} */