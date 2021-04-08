variable "volume_size" {
  description = "Volume size of root device"
  type        = number
  default     = 10
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t3.micro"
}

variable "ingress_cidr_blocks" {
  description = "Allow traffic from Cidr blocks, override for internal Cidr blocks"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "app_id" {
  description = "Application ID"
  type        = string
  default     = "mongo-ec2"
}
