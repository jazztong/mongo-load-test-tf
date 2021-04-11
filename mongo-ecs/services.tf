resource "aws_ecs_service" "this" {
  name        = "${var.app_id}-service"
  cluster     = aws_ecs_cluster.this.id
  launch_type = "EC2"

  task_definition = aws_ecs_task_definition.this.arn

  desired_count = 1

  service_registries {
    registry_arn   = aws_service_discovery_service.this.arn
    container_port = 27017
    container_name = var.app_id
  }
}
