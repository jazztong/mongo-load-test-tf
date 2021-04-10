resource "aws_security_group" "sg" {
  name        = "${local.app_id}-SG"
  description = "Security group to allow access to Test Client"
  vpc_id      = data.aws_vpc.this.id

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = var.ingress_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "mongo-ec2-sg"
  }
}
