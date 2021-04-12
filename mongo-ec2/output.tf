output "output" {
  value = {
    fqdn       = aws_route53_record.this.fqdn
    public_dns = aws_instance.this.public_dns
  }
}
