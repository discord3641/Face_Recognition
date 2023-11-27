
#AWS Providerの設定
provider "aws" {
    region = "ap-northeast-1"
}

#VPCの作成
resource "aws_vpc" "my_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "my-vpc"
    }
}

#public-subnetの作成provider
resource "aws_subnet" "my_public_subnet" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = "10.0.1.0/24"
    tags = {
        name = "my-public-subnet"
    }
}

#route-tableの作成
resource "aws_route_table" "my_route_table" {
    vpc_id = aws_vpc.my_vpc.id
    tags = {
        name = "my-route-table"
    }
}

#internet-gatewayの作成
resource "aws_internet_gateway" "my_igw" {
    vpc_id = aws_vpc.my_vpc.id
    tags = {
        name = "my-igw"
    }
}

#igwとrotue-tableの紐づけ
resource "aws_route" "my_igw_route" {
    route_table_id = aws_route_table.my_route_table.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
}