/*
project/
├── modules/
│   ├── ec2_instance/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── dynamodb_table/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
├── us-east-1/
│   ├── main.tf
├── eu-west-1/
│   ├── main.tf

OR

project/
├── modules/
│   ├── ec2_instance/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── dynamodb_table/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
├── main.tf

provider "aws" {
  region = "eu-west-1"
  alias  = "eu"
}

provider "aws" {
  region = "us-east-1"
  alias  = "us"
}

module "ec2_instance_us_east" {
  source         = "./modules/ec2_instance"
  instance_count = 2
  ami_id         = "ami-04e5276ebb8451442"
  instance_type  = "t2.micro"
  key_name       = "MyAWSKey"
  instance_name  = "example-instance-us-east"
}

module "ec2_instance_eu_west" {
  source         = "./modules/ec2_instance"
  instance_count = 2
  ami_id         = "ami-0d9ad17690d6709b8"
  instance_type  = "t2.micro"
  key_name       = "MyAWSKey"
  instance_name  = "example-instance-eu-west"
}

module "dynamodb_table_us_east" {
  source       = "./modules/dynamodb_table"
  table_name   = "example-table-us-east"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "ID"
}

module "dynamodb_table_eu_west" {
  source       = "./modules/dynamodb_table"
  table_name   = "example-table-eu-west"
  billing_mode = "PROVISIONED"
  hash_key     = "ID"
}

output "ec2_instance_ids_us_east" {
  value = module.ec2_instance_us_east.instance_id
}

output "ec2_instance_ids_eu_west" {
  value = module.ec2_instance_eu_west.instance_id
}

output "dynamodb_table_name_us_east" {
  value = module.dynamodb_table_us_east.table_name
}

output "dynamodb_table_name_eu_west" {
  value = module.dynamodb_table_eu_west.table_name
}
*/