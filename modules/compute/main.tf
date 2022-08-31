#Launch EC2 Instance
resource "aws_instance" "webserver" {
  ami           = "ami-05fa00d4c63e32376"
  instance_type = "t2.micro" 
  subnet_id = data.aws_subnet.dsubnet-a-public.id
  key_name  = aws_key_pair.webserver_key.key_name
  vpc_security_group_ids = [var.allow_http_ssh-id]
tags = {
    Name = "webserver_task1"
  }
  connection {
        type    = "ssh"
        user    = "ec2-user"
        host    = aws_instance.webserver.public_ip
        port    = 22
        private_key = tls_private_key.webserver_private_key.private_key_pem
    }
  provisioner "remote-exec" {
        inline = [
        "sudo yum install httpd php git -y",
        "sudo systemctl start httpd",
        "sudo systemctl enable httpd",
        ]
    }
}

#create Key Pair
resource "tls_private_key" "webserver_private_key" {
 algorithm = "RSA"
 rsa_bits = 4096
}
resource "local_file" "private_key" {
 content = tls_private_key.webserver_private_key.private_key_pem
 filename = "webserver_key.pem"
 file_permission = 0400
}
resource "aws_key_pair" "webserver_key" {
 key_name = "webserver"
 public_key = tls_private_key.webserver_private_key.public_key_openssh
}