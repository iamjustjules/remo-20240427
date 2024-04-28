resource "aws_instance" "example" {
  count         = var.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  # Add other necessary configurations

  tags = {
    Name = var.instance_name
  }
}
