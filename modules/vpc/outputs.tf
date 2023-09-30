output "mtc_security_id" {
  value = aws_security_group.mtc_sg.id
}

output "mtc_public_subnet_id" {
  value = aws_subnet.mtc_public_subnet.id

}