variable "work_zone" {
  description = "Zone"
  # Значение по умолчанию
  default = "europe-west1-b"
}
variable "public_key_path" {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}
variable source_ranges {
    description = "Allowed IP addresses"
    default = ["0.0.0.0/0"]
}
