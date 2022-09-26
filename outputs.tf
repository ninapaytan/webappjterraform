output "Public_IP" {
  description = "instance DNS name for connecting to web page"
  value = "${module.compute.IP}" 
}

