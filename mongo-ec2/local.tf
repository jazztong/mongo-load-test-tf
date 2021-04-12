locals {
  app_id = var.app_id
  role_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  ]

  user_data = templatefile("${path.module}/tmpl/user_data.tmpl.sh", {
    ssm_cloudwatch_config = aws_ssm_parameter.cw_agent.name
  })
}
