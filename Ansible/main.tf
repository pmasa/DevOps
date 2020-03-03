provider "aws" {
  profile = "default"
  region  = "eu-west-1"
}

resource "aws_instance" "server" {
  count = 2
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = "admin"
  root_block_device {
    volume_size           = "10"
    volume_type           = "standard"
    delete_on_termination = "true"
  }
  tags = {
    Name = "server${count.index}"
  }
  provisioner "local-exec" {
    command = "ansible-playbook -i '${self.public_ip},' playbook.yml --extra-vars ipv4='${self.public_ip}'"
  }
}

variable "key_pair_path" {
  type = map(string)
  default = {
    public_key_path = "~/.ssh/id_rsa.pub"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_key_pair" "admin" {
  key_name   = "admin"
  public_key = file(var.key_pair_path["public_key_path"])
}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_default_security_group" "default" {
  vpc_id = aws_default_vpc.default.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
