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
    bucket     = "my-tfstate-bucket"
    region     = "ru-central1"
    key        = "prod/terraform.tfstate"
    access_key = "YCAJEeTbqXplx9A0gi8ysCSdU"
    secret_key = "YCNe73ABP-_ylpewqUoiFLcfdaTQBaPCpUddp39x"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
