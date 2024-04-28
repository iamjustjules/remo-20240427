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

*/

provider "aws" {
  region = "us-east-1"
  alias  = "us-east-1"
}

resource "aws_instance" "us-east-1" {
 provider = aws.us-east-1
 # Note different AMI IDs!!
 ami = "ami-04e5276ebb8451442"
 instance_type = "t2.micro"
 key_name = "MyAWSKey"
}

data "aws_ami" "us-east-1" {
 #provider = aws.us-east-1
 most_recent = true
 owners = ["137112412989"] # Canonical
 filter {
 name = "name"
 values = ["amazon/al2023-ami-2023.4.20240416.0-kernel-6.1-x86_64"]
 }
}

/*
module "ec2_instance_us_east" {
  source         = "./modules/ec2_instance"
  instance_count = 2
  ami_id         = "ami-04e5276ebb8451442"
  instance_type  = "t2.micro"
  key_name       = "MyAWSKey"
  instance_name  = "example-instance-us-east"
}
*/

module "dynamodb_table_us_east" {
  source       = "./modules/dynamodb_table"
  table_name   = "example-table-us-east"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "ID"
}

output "us-east-1" {
  value = aws_instance.us-east-1.availability_zone
  description = "the name of the 1st region"
}

output "dynamodb_table_name_us_east" {
  value = module.dynamodb_table_us_east.table_name
}