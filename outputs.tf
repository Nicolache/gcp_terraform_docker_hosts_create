output "docker_external_ip" {
  value = "${module.docker.docker_external_ip}"
}
output "private_key" {
  value = var.private_key_path
}
