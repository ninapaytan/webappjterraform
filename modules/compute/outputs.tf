#Output
output "IP"{
 value=aws_instance.webserver.public_ip
}