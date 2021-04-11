variable "ingress_cidr_blocks" {
  description = "Allow traffic from Cidr blocks, override for internal Cidr blocks"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "app_id" {
  description = "Application ID"
  type        = string
  default     = "mongo-fargate"
}

variable "memory" {
  description = "Fargate Memory"
  type        = number
  default     = 8192
}

variable "cpu" {
  description = "Fargate CPU"
  type        = number
  default     = 2048
}

variable "provisioned_throughput_in_mibps" {
  description = "EFS througput"
  type        = number
  default     = 150
}
