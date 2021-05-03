terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

terraform {
  # Версия terraform
  # required_version = "0.11.11"
  required_version = "0.15.1"
}
provider "google" {
  # Версия провайдера
  #    version = "2.0.0"
  #   version = "3.66.1"

  # ID проекта
  project = var.project

  region = var.region
}

module "app" {
    source = "../modules/app"
    public_key_path = "${var.public_key_path}"
    private_key_path = "${var.private_key_path}"
    app_disk_image = "${var.app_disk_image}"
}

module "db" {
    source = "../modules/db"
    public_key_path = "${var.public_key_path}"
    db_disk_image = "${var.db_disk_image}"
}

module "vpc" {
    source = "../modules/vpc"
    public_key_path = "${var.public_key_path}"
    source_ranges = ["0.0.0.0/0"]
}
