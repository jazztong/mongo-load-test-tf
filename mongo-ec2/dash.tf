locals {
  dash_json = templatefile("${path.module}/tmpl/dash.tmpl.json", {
    REGION   = data.aws_region.this.name
    EC2_ID   = aws_instance.this.id
    EC2_HOST = aws_instance.this.private_dns
  })
}

resource "aws_cloudwatch_dashboard" "this" {
  dashboard_name = "${var.app_id}-dashboard"

  dashboard_body = local.dash_json
}
