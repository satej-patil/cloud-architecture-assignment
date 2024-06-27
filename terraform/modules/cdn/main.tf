resource "google_compute_backend_bucket" "default" {
  name        = "backend-bucket"
  bucket_name = var.bucket_name
  project = var.project_id
}

resource "google_compute_url_map" "default" {
  name            = "url-map"
  default_service = google_compute_backend_bucket.default.id
  project = var.project_id
}

resource "google_compute_target_http_proxy" "default" {
  name        = "http-proxy"
  url_map     = google_compute_url_map.default.id
  project = var.project_id
}

resource "google_compute_global_forwarding_rule" "default" {
  name        = "forwarding-rule"
  target      = google_compute_target_http_proxy.default.id
  port_range  = "80"
  ip_protocol = "TCP"
  project = var.project_id
}
