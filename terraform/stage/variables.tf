variable "cloud_id" {
  description = "Cloud"
}

variable "folder_id" {
  description = "Folder"
}

variable "zone" {
  description = "Zone"
  default     = "ru-central1-a"
}

variable "public_key_path" {
  description = "Path to the public key used for ssh access"
}

variable "image_id" {
  description = "Image"
}

variable "subnet_id" {
  description = "Subnet"
}

variable "service_account_key_file" {
  description = "key.json"
}

variable "private_key_path" {
  description = "Private key"
}

variable "resource_zone" {
  description = "Resource zone"
  default     = "ru-central1-a"
}

variable "lb_region" {
  description = "Load balancer region"
  default     = "ru-central1"
}

variable "app_disk_image" {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}

variable "db_disk_image" {
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
}
