output "app_external_ip" {
  value = module.app.app_external_ip
}
output "database_url" {
  value = module.db.db_internal_ip
}
