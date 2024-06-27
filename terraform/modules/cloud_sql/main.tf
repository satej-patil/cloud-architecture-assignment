resource "google_sql_database_instance" "default" {
  name             = "sql-instance"
  region           = var.region
  database_version = "MYSQL_5_7"

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      private_network = var.vpc_id
    }
  }
}
