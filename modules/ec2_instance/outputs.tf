output "instance_id" {
  description = "The IDs of the EC2 instances"
  value       = aws_instance.example[*].id
}