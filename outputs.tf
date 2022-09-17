output "For_connecting_website" {
  description = "instance DNS name for connecting to web page"
  value = "${module.compute.IP}"
}