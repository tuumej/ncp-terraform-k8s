terraform {
  required_providers {
    ncloud = {
      source = "NaverCloudPlatform/ncloud"
      version = "2.3.18"
    }
  }
}

provider "ncloud" {
  support_vpc = true
  region      = var.region
  access_key  = var.access_key
  secret_key  = var.secret_key
}