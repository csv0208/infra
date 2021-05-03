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

resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "g1-small"
  zone         = var.work_zone
  tags         = ["reddit-app"]

  metadata = {
    # путь до публичного ключа
    #    ssh-keys = "appuser:${file(var.public_key_path)}"
    "ssh-keys" = <<EOT
                appuser:${file(var.public_key_path)}
                appuser1:${file(var.public_key_path)}
                appuser2:${file(var.public_key_path)}
            EOT
  }

  # определение загрузочного диска
  boot_disk {
    initialize_params {
      image = var.disk_image
    }
  }

  # определение сетевого интерфейса
  network_interface {
    # сеть, к которой присоединить данный интерфейс
    network = "default"
    # использовать ephemeral IP для доступа из Интернет
    access_config {}
  }

  connection {
    type  = "ssh"
    user  = "appuser"
    agent = false
    # путь до приватного ключа
    private_key = file(var.private_key_path)
    host        = google_compute_instance.app.network_interface.0.access_config.0.nat_ip
  }

  provisioner "file" {
    source      = "files/puma.service"
    destination = "/home/appuser/puma.service"

  }
  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}

resource "google_compute_firewall" "firewall_puma" {
  name = "allow-puma-default"
  # Название сети, в которой действует правило
  network = "default"
  # Какой доступ разрешить
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }
  # Каким адресам разрешаем доступ
  source_ranges = ["0.0.0.0/0"]
  # Правило применимо для инстансов с перечисленными тэгами
  target_tags = ["reddit-app"]
}
