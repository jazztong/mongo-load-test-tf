output "output" {
  value = {
    service_dns = "${aws_service_discovery_service.this.name}.${aws_service_discovery_private_dns_namespace.this.name}"
  }
}
