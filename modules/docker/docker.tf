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
    ssh-keys = "dockeruser:${file("${var.public_key_path}")}"
  }
  provisioner "remote-exec" {
    script = "files/docker.deploy.sh"
    # inline = [
    #   "sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D",
    #   "sudo apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'",
    #   "sudo apt-get update",
    #   "sudo apt-get install -y docker-engine",
    # ]
  }
  connection {
    host = google_compute_address.docker_ip.address
    type = "ssh"
    user = "dockeruser"
    agent = false
    private_key = file(var.private_key_path)
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
