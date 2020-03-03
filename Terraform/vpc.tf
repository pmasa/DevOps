resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "private-subnet1" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-west-2a"
}

resource "aws_subnet" "private-subnet2" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "eu-west-2b"
}

resource "aws_db_subnet_group" "db-subnet" {
  name       = "db subnet group"
  #subnet_ids = ["${aws_subnet.private-subnet1.id}", "${aws_subnet.private-subnet2.id}"]
  subnet_ids = ["${aws_subnet.private-subnet2.id}"]
}


resource "aws_db_instance" "db" {
  allocated_storage    = "20"
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7.22"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "admin"
  password             = "admin"
  parameter_group_name = "db-mysql"
  db_subnet_group_name = "db-subnet"
}