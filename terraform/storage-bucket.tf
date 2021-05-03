terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

terraform {
  required_version = "0.15.1"
}
provider "google" {
  # ID проекта
  project = var.project

  region = var.region
}

module "storage-bucket" {
    source = "SweetOps/storage-bucket/google"
    version = "0.1.1"
    # Имена поменяйте на другие
    name = ["terraform2-stage", "terraform2-prod"]
}
