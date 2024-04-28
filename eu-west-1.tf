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
  region = "eu-west-1"
  alias  = "eu-west-1"
}

resource "aws_instance" "eu-west-1" {
 provider = aws.eu-west-1
 # Note different AMI IDs!!
 ami = "ami-0d9ad17690d6709b8"
 instance_type = "t2.micro"
 key_name = "MyLinuxBox"
}

data "aws_ami" "eu-west-1" {
 #provider = aws.eu-west-1
 most_recent = true
 owners = ["679593333241"] # Canonical
 filter {
 name = "name"
 values = ["aws-marketplace/Apss4Rent-nginx-Aws ec2-prod-uscs3x5bl2khu"]
 }
}

/*
module "eu-west-1" {
  source         = "./modules/ec2_instance"
  instance_count = 2
  ami_id         = "ami-0d9ad17690d6709b8" #"ami-04e5276ebb8451442"
  instance_type  = "t2.micro"
  key_name       = "MyAWSKey"
  instance_name  = "example-instance-eu-west"  
}
*/

module "dynamodb_table_eu_west" {
  source       = "./modules/dynamodb_table"
  table_name   = "example-table-eu-west"
  billing_mode = "PROVISIONED"
  hash_key     = "ID"
}


output "eu-west-1" {
  value = aws_instance.eu-west-1.availability_zone
  description = "the name of the 2nd region"
}

output "dynamodb_table_name_eu_west" {
  value = module.dynamodb_table_eu_west.table_name
}