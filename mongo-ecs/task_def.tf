resource "aws_ecs_task_definition" "this" {
  family = var.app_id
  memory = var.memory
  //cpu                      = var.cpu
  requires_compatibilities = ["EC2"]
  task_role_arn            = aws_iam_role.task.arn
  execution_role_arn       = aws_iam_role.task.arn
  network_mode             = "bridge"

  container_definitions = jsonencode(
    [{
      "name" : var.app_id
      "image" : "mongo:4.4",
      "portMappings" : [
        {
          "HostPort" : 27017,
          "containerPort" : 27017,
        }
      ],
      "environment" : [
        {
          "name" : "MONGO_INITDB_ROOT_USERNAME",
          "value" : "root"
        },
        {
          "name" : "MONGO_INITDB_ROOT_PASSWORD",
          "value" : "mypassword"
        }
      ],
      "logConfiguration" : {
        "logDriver" : "awslogs",
        "options" : {
          "awslogs-create-group" : "true",
          "awslogs-group" : "/ecs/mongo-fargate",
          "awslogs-region" : "ap-southeast-1",
          "awslogs-stream-prefix" : "ecs"
        }
      },
    }]
  )
}
