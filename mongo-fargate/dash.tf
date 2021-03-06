locals {
  dash_json = templatefile("${path.module}/tmpl/dash.tmpl.json", {
    REGION       = data.aws_region.this.name
    SERVICE_NAME = aws_ecs_service.this.name
    CLUSTER_NAME = aws_ecs_cluster.this.name
    FILE_SYSTEM_ID    = aws_efs_file_system.this.id
  })
}

resource "aws_cloudwatch_dashboard" "this" {
  dashboard_name = "${var.app_id}-dashboard"

  dashboard_body = local.dash_json
}
