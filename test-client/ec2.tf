resource "aws_instance" "this" {
  ami                    = data.aws_ami.amzlinux2.id
  iam_instance_profile   = aws_iam_instance_profile.this.name
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg.id]
  subnet_id              = tolist(data.aws_subnet_ids.this.ids)[0]

  root_block_device {
    volume_size = var.volume_size
  }

  user_data_base64 = data.template_cloudinit_config.userdata.rendered
  tags = {
    Name = "testclient-ec2-load-test"
  }
}
