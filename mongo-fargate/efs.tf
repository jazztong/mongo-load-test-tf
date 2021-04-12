resource "aws_efs_file_system" "this" {
  tags = {
    Name = "${var.app_id}-efs"
  }
  encrypted = true
  # Turn off provisioned IOPS
  # performance_mode                = "maxIO"
  # throughput_mode                 = "provisioned"
  # provisioned_throughput_in_mibps = var.provisioned_throughput_in_mibps
}

resource "aws_efs_mount_target" "this" {
  for_each = data.aws_subnet_ids.this.ids

  file_system_id  = aws_efs_file_system.this.id
  security_groups = [aws_security_group.this.id]
  subnet_id       = each.value
}
