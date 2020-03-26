variable project {
  description = "Project ID"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable private_key_path {
  description = "Path to the private key used for ssh access"
}

variable docker_disk_image {
  description = "Disk image for docker."
  default = "reddit-docker-base"
}
