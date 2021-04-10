resource "aws_route53_zone" "private" {
  name = "loadtest.internel"

  vpc {
    vpc_id = data.aws_vpc.this.id
  }
}

resource "aws_route53_record" "this" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "mongo-ec2"
  type    = "CNAME"
  ttl     = "86400"
  records = [aws_instance.this.private_dns]
}