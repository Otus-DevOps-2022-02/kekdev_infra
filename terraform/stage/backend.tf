terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.35"
    }
  }
  required_version = ">= 0.12.0"

  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    region     = "ru-central1"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
