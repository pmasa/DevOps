
resource "aws_instance" "web1" {
    ami = "ami-04de2b60dd25fbb2e"
    instance_type = "t2.micro"
    # VPC
    subnet_id = aws_subnet.private-subnet1.id
    # Security Group
    vpc_security_group_ids = [aws_security_group.ssh-allowed.id]
    # the Public SSH key
    key_name = aws_key_pair.london-region-key-pair.id
    # nginx installation
    
}
// Sends your public key to the instance
#resource "aws_key_pair" "london-region-key-pair" {
#    key_name = "london-region-key-pair"
#    public_key = "${file(var.PUBLIC_KEY_PATH)}"
#}
// Sends your public key to the instance
resource "aws_key_pair" "london-region-key-pair" {
    #key_name = "london-region-key-pair"
    #public_key = "${file(var.PUBLIC_KEY_PATH)}"
    key_name = "london-region-key-pair"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC1i8i+AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAZZZZZZZZZZZZZZZZZZZZZ"
}

