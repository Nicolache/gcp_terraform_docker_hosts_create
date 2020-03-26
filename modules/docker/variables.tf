# variable project {
#   description = "Project ID"
# }

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

# variable disk_image {
#   description = "Disk image"
# }
# 
variable docker_disk_image {
  description = "Disk image for docker."
  default = "reddit-docker-base"
}

# variable db_disk_image {
#   description = "Disk image for reddit db."
#   default = "reddit-db-base"
# }
