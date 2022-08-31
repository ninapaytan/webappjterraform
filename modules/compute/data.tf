data "aws_subnet" "dsubnet-a-public" {
  id = var.subnet-a-public
}

data "aws_subnet" "dsubnet-b-public" {
  id = var.subnet-b-public
}

data "aws_subnet" "dsubnet-a-private" {
  id = var.subnet-a-private
}

data "aws_subnet" "dsubnet-b-private" {
  id = var.subnet-b-private
}

data "aws_security_group" "dallow_http_ssh-id" {
  id = var.allow_http_ssh-id
}