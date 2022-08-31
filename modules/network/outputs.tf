output "vpc-adolfo-id" {
  value = aws_vpc.vpc-adolfo.id
}

output "subnet-a-public-id" {
  value = aws_subnet.subnet-a-public.id
}

output "subnet-b-public-id" {
  value = aws_subnet.subnet-b-public.id
}

output "subnet-a-private-id" {
  value = aws_subnet.subnet-a-private.id
}

output "subnet-b-private-id" {
  value = aws_subnet.subnet-b-private.id
}