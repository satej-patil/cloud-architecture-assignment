resource "google_redis_instance" "default" {
  name           = "redis-instance"
  region         = var.region
  tier           = "STANDARD_HA"
  memory_size_gb = 1
  authorized_network = var.vpc_id
}
