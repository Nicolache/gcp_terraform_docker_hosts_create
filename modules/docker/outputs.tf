# output "docker_external_ip" {
#   # value = "${google_compute_instance.docker.network_interface.0.access_config.0.nat_ip}"
#   value = "${google_compute_instance.docker[count.index].network_interface.0.access_config.0.nat_ip}"
# }
