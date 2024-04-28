resource "aws_dynamodb_table" "example" {
  name           = var.table_name
  billing_mode   = "PROVISIONED"
  read_capacity  = 2
  write_capacity = 2
  hash_key       = var.hash_key
  # Add other necessary configurations

  attribute {
    name = "ID"
    type = "S"  # Assuming ID is a string type. Change it as per your requirement
  }
}
