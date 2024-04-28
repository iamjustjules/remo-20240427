variable "table_name" {
  description = "Name of the DynamoDB table"
  type        = string
}

variable "billing_mode" {
  description = "Billing mode for the DynamoDB table"
  type        = string
}

variable "hash_key" {
  description = "Hash key for the DynamoDB table"
  type        = string
}
