provider "google" {
  zone = "europe-west6-b"
  project = var.project
}

module "docker" {
  source = "./modules/docker"
  public_key_path = var.public_key_path
  private_key_path = var.private_key_path
  docker_disk_image = var.docker_disk_image
}
