variable "volume_size" {
  description = "Volume size of root device"
  type        = number
  default     = 50
}

variable "volume_iops" {
  description = "Volume iops size, only apply to io1 io2"
  type        = number
  default     = 1000
}

variable "volume_type" {
  description = "Volume type use in EC2,gp,io1,io2"
  type        = string
  default     = "io1"
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
  default     = "mongo-ec2"
}
