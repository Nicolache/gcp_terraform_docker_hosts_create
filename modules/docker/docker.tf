resource "google_compute_instance" "docker" {
  count = 2
  name         = "docker-host${count.index + 1}"
  machine_type = "g1-small"
  tags         = ["docker-host${count.index + 1}"]
  # tags = {
  #   Name = "Docker-${count.index + 1}"
  #   Batch = "DockerBatch"
  # }
  boot_disk {
    initialize_params {
      image = var.docker_disk_image
    }
  }
  network_interface {
    network = "default"
    access_config {
      # nat_ip = google_compute_address.docker_ip.address
      nat_ip = google_compute_address.docker_ip[count.index].address
    }
  }
  metadata = {
    ssh-keys = "dockeruser:${file("${var.public_key_path}")}"
  }
  provisioner "remote-exec" {
    script = "files/docker.deploy.sh"
  }
  connection {
    # host = google_compute_address.docker_ip.address
    host = google_compute_address.docker_ip[count.index].address
    type = "ssh"
    user = "dockeruser"
    agent = false
    private_key = file(var.private_key_path)
  }
}

resource "google_compute_address" "docker_ip" {
  name = "docker-host-ip${count.index}"
  count = 2
  region = "europe-west6"
}

resource "google_compute_firewall" "firewall_puma" {
  name = "allow-puma-default"
  network = "default"
  allow {
    protocol = "tcp"
#     ports = ["9292"]
    ports = ["2376"]
  }
  source_ranges = ["0.0.0.0/0"]
  # target_tags = ["docker-host"]
}
