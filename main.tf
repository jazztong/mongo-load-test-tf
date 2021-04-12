terraform {
  required_version = ">= 0.14.9"
}

module "mongo-ec2" {
  source = "./mongo-ec2"
}

module "mongo-fargate" {
  source = "./mongo-fargate"
}

module "mongo-ecs" {
  source = "./mongo-ecs"
}

module "test-client" {
  source = "./test-client"
}

output "output" {
  value = {
    login = {
      username = "root"
      password = "mypassword"
    }
    test-client   = module.test-client.output
    mongo-ecs     = module.mongo-ecs.output
    mongo-fargate = module.mongo-fargate.output
    mongo-ec2     = module.mongo-ec2.output
  }
}
