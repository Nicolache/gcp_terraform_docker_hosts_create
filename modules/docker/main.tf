resource "google_compute_instance" "docker" {
  name         = "docker-host"
  machine_type = "g1-small"
  tags         = ["docker-host"]
  boot_disk {
    initialize_params {
      image = var.docker_disk_image
    }
  }
  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.docker_ip.address
    }
  }
  metadata = {
    sshKeys = "dockeruser:${file("${var.public_key_path}")}"
  }
}

resource "google_compute_address" "docker_ip" {
  name = "docker-host-ip"
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
  target_tags = ["docker-host"]
}
provisioner "remote-exec" {
  script = "files/docker.deploy.sh"
}
connection {
  type = "ssh"
  user = "dockeruser"
  agent = false
  private_key = "${file("~/.ssh/id_rsa")}"
}
