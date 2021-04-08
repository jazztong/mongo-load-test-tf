locals {
  app_id = var.app_id
  role_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  ]

  user_data = templatefile("${path.module}/tmpl/user_data.tmpl.sh", {})
}
