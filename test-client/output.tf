output "output" {
  value = {
    public_dns = aws_instance.this.public_dns
  }
}
