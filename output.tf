output "ec2_public_ip1" {
  value = aws_instance.web_public1.public_ip
}
output "ec2_public_ip2" {
  value = aws_instance.web_public2.public_ip
}
output "ec2_public_ip3" {
  value = aws_instance.web_public3.public_ip
}