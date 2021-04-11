resource "aws_ecs_task_definition" "this" {
  family                   = var.app_id
  memory                   = var.memory
  cpu                      = var.cpu
  requires_compatibilities = ["FARGATE"]
  task_role_arn            = aws_iam_role.task.arn
  execution_role_arn       = aws_iam_role.task.arn
  network_mode             = "awsvpc"

  volume {
    name = "data"
    efs_volume_configuration {
      file_system_id     = aws_efs_file_system.this.id
      root_directory     = "/"
      transit_encryption = "ENABLED"
      authorization_config {
        iam = "ENABLED"
      }
    }
  }

  container_definitions = jsonencode(
    [{
      "name" : var.app_id
      "image" : "mongo:4.4",
      "portMappings" : [
        { containerPort = 27017 }
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
      "mountPoints" : [
        {
          "readOnly" : null,
          "containerPath" : "/data/db",
          "sourceVolume" : "data"
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
