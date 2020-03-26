provider "google" {
  zone = "europe-west6-b"
  project = var.project
  region  = var.region
}

module "docker" {
  source = "./modules/docker"
  public_key_path = var.public_key_path
  source_ranges = ["94.241.0.0/16"]
  docker_disk_image = var.docker_disk_image
}
