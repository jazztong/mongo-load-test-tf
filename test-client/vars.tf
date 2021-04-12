variable "volume_size" {
  description = "Volume size of root device"
  type        = number
  default     = 10
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "m5.large"
}

variable "ingress_cidr_blocks" {
  description = "Allow traffic from Cidr blocks, override for internal Cidr blocks"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "app_id" {
  description = "Application ID"
  type        = string
  default     = "testclient-ec2"
}
