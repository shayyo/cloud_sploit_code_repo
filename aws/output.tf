output "Nginx_instance_public_ip_addr" {
  value = aws_instance.nginx_server[*].public_ip
}

output "Nginx_instance_private_ip_addr" {
  value = aws_instance.nginx_server[*].private_ip
}

output "Database_instance_public_ip_addr" {
  value = aws_instance.web_app_db_host[*].public_ip
}

output "Database_instance_private_ip_addr" {
  value = aws_instance.web_app_db_host[*].private_ip
}
