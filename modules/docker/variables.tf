variable region {
  description = "Region"
  default     = "europe-west6"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable private_key_path {
  description = "Path to the private key used for ssh access"
}

variable private_key_absolute_path {
  description = "Path to the private key used for ssh access"
}

variable number_of_instances {
  description = "Machines quantity"
}

variable docker_disk_image {
  description = "Disk image for docker."
  default = "reddit-docker-base"
}
