terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  backend "local" { }
}

provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

resource "yandex_storage_bucket" "bucket" {
  access_key = var.access_key
  secret_key = var.secret_key
  bucket     = var.bucket_name

  versioning {
    enabled = true
  }
}

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

variable "service_account_key_file" {
  description = "Service account key file"
}

variable "access_key" {
  description = "Access key"
}

variable "secret_key" {
  description = "Secret key"
}

variable "bucket_name" {
  description = "Bucket name"
}

output "bucket_domain" {
  value = yandex_storage_bucket.bucket.bucket_domain_name
}
