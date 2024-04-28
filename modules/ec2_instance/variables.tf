variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
}

variable "ami_id" {
  description = "AMI ID for the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the EC2 instances"
  type        = string
}

variable "key_name" {
  description = "SSH key pair name for the EC2 instances"
  type        = string
}

variable "instance_name" {
  description = "Name tag for the EC2 instances"
  type        = string
}
