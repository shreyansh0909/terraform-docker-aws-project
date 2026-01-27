output "instance_public_ip" {
  value = aws_instance.aicode01.public_ip

}

output "instance_url" {
  value = "http://${aws_instance.aicode01.public_ip}"

}